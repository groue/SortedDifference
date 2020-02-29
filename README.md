# SortedDifference

This package defines the `SortedDifference` sequence, which computes the difference between two sorted Swift sequences.

It aims as making it easy to synchronize two heterogeneous lists, such as a server payload and a local database.

For example, the sample code below synchronizes the content of the database with the server data, with [Alamofire](https://github.com/Alamofire/Alamofire) and [GRDB](https://github.com/groue/GRDB.swift):

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
            let dbPlayers = DatabasePlayer.orderByPrimaryKey().fetchAll(db)
            
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

This technique has a low complexity, and performs as little database I/O as possible:

- The api players are sorted in O(n log n)
- Database players, sorted by primary key, are fetched in a single efficient SQL request
- SortedDifference iteration is O(n)
- Each insertion and deletion runs one SQL request
- Each update only runs an SQL request if there are actual changes

When database and server are already synchronized, a single SQL request is executed, and the database is not changed.
