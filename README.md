# SortedDifference

This Swift package defines the `SortedDifference` sequence, which computes the difference between two sequences of identifiable elements.

- [Motivation]
- [Reference]

## Motivation

SortedDifference eases, for example, the synchronization of a server payload and a local database.

The sample code below uses [Alamofire](https://github.com/Alamofire/Alamofire) and [GRDB](https://github.com/groue/GRDB.swift).

It has a low complexity, and performs as little database I/O as possible:

- The api players are sorted in O(n log n)
- Database players, sorted by primary key, are fetched in a single efficient SQL request
- The iteration of SortedDifference is O(n)
- Each insertion and deletion runs one SQL request
- Each update only runs an SQL request if there are actual changes

When database and server are already synchronized, a single SQL request is executed, and the database is not changed.

```swift
struct APIPlayer: Decodable, Identifiable { ... }
struct DatabasePlayer: FetchableRecord, PersistableRecord, Identifiable { ... }

extension DatabasePlayer {
    init(_ player: APIPlayer) { ... }
}

// Load all api players
AF.request("https://example.com/players").responseDecodable(of: [APIPlayer].self) { response in
    do {
        // Sort api players by id
        let apiPlayers = try response.result.get().sorted(by: { $0.id < $1.id })
        
        // Synchronize players in a database transaction
        try database.write { db in
            // Fetch database players, sorted by id
            let dbPlayers = try DatabasePlayer.orderByPrimaryKey().fetchAll(db)
            
            for change in SortedDifference(left: dbPlayers, right: apiPlayers) {
                switch change {
                    case let .left(dbPlayer):
                        // Player exists in the database, but not on the server: delete it
                        try dbPlayer.delete(db)
                        
                    case let .right(apiPlayer):
                        // Player exists on the server, but not in the database: insert it
                        let newPlayer = DatabasePlayer(apiPlayer)
                        try newPlayer.insert(db)
                        
                    case let .common(dbPlayer, apiPlayer):
                        // Player exists on the server and in the database: update if needed
                        let newPlayer = DatabasePlayer(apiPlayer)
                        try newPlayer.updateChanges(db, from: dbPlayer)
                }
            }
        }
    } catch {
        // handle network or database error
    }
}
```


## Reference

SortedDifference comes with a general initializer, and two convenience initializers.

The general initializer is the less constrained: it lets you provide closures that return identifiers of both left and right elements:

```swift
struct SortedDifference<LeftSequence, RightSequence, ID>: Sequence where
    LeftSequence: Sequence,
    RightSequence: Sequence,
    ID: Comparable
{
    init(
        left: LeftSequence,
        identifiedBy leftID: @escaping (LeftSequence.Element) -> ID,
        right: RightSequence,
        identifiedBy rightID: @escaping (RightSequence.Element) -> ID)
}

// Prints 
// - common(1, 1)
// - left(2)
for change in SortedDifference(
    left: [1, 2],
    identifiedBy: { "\($0)" },
    right: ["1"],
    identifiedBy: { "\($0)" })
{
    print(change)
}
```

There is a convenience initializer for sequences of Identifiable types:

```swift
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension SortedDifference where
    LeftSequence.Element: Identifiable,
    RightSequence.Element: Identifiable,
    LeftSequence.Element.ID == ID,
    RightSequence.Element.ID == ID
{
    init(left: LeftSequence, right: RightSequence)
}

// Prints:
// - common(Left(id: 1), Right(id: 1))
// - left(Left(id: 2))
struct Left: Identifiable { var id: Int }
struct Right: Identifiable { var id: Int }
for change in SortedDifference(
    left: [Left(id: 1), Left(id: 2)],
    right: [Right(id: 1)])
{
    print(change)
}
```

There is a convenience initializer for sequences of Comparable types:

```swift
extension SortedDifference where
    LeftSequence.Element: Comparable,
    RightSequence.Element == LeftSequence.Element,
    LeftSequence.Element == ID
{
    init(left: LeftSequence, right: RightSequence)
}

// Prints:
// - common(1, 1)
// - left(2)
for change in SortedDifference(left: [1, 2], right: [1]) {
    print(change)
}
```

All initializers share a common set of preconditions:

1. Both left and right sequences must be sorted by identifier.
2. Left and right sequences must not contain two elements that share a common identifier.

Those preconditions are not checked. If they are not honored, the behavior of SortedDifference is undefined.

[Motivation]: #motivation
[Reference]: #reference
