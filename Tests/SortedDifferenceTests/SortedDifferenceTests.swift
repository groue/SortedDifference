import XCTest
@testable import SortedDifference

private struct ID: Comparable {
    var value: String
    static func == (lhs: ID, rhs: ID) -> Bool {
        return lhs.value == rhs.value
    }
    static func < (lhs: ID, rhs: ID) -> Bool {
        return lhs.value < rhs.value
    }
}

final class SortedDifferenceTests: XCTestCase {
    func testSortedDifference() {
        XCTAssertEqual(
            Array(SortedDifference(left: [Int](), right: [])),
            [])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [], right: [0])),
            [.right(0)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [], right: [0, 1])),
            [.right(0), .right(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [], right: [0, 1, 2])),
            [.right(0), .right(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [], right: [0, 1, 2, 3])),
            [.right(0), .right(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [])),
            [.left(0)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [0])),
            [.common(0, 0)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [0, 1])),
            [.common(0, 0), .right(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [0, 1, 2])),
            [.common(0, 0), .right(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [0, 1, 2, 3])),
            [.common(0, 0), .right(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [1])),
            [.left(0), .right(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [1, 2])),
            [.left(0), .right(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0], right: [1, 2, 3])),
            [.left(0), .right(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [])),
            [.left(0), .left(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0])),
            [.common(0, 0), .left(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0, 1])),
            [.common(0, 0), .common(1, 1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0, 1, 2])),
            [.common(0, 0), .common(1, 1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0, 1, 2, 3])),
            [.common(0, 0), .common(1, 1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0, 2])),
            [.common(0, 0), .left(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [0, 2, 3])),
            [.common(0, 0), .left(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [1])),
            [.left(0), .common(1, 1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [1, 2])),
            [.left(0), .common(1, 1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [1, 2, 3])),
            [.left(0), .common(1, 1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [2])),
            [.left(0), .left(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1], right: [2, 3])),
            [.left(0), .left(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [])),
            [.left(0), .left(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0])),
            [.common(0, 0), .left(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 1])),
            [.common(0, 0), .common(1, 1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 1, 2])),
            [.common(0, 0), .common(1, 1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 1, 2, 3])),
            [.common(0, 0), .common(1, 1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 1, 3])),
            [.common(0, 0), .common(1, 1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 2])),
            [.common(0, 0), .left(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 2, 3])),
            [.common(0, 0), .left(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [0, 3])),
            [.common(0, 0), .left(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [1])),
            [.left(0), .common(1, 1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [1, 2])),
            [.left(0), .common(1, 1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [1, 2, 3])),
            [.left(0), .common(1, 1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [1, 3])),
            [.left(0), .common(1, 1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [2])),
            [.left(0), .left(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [2, 3])),
            [.left(0), .left(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2], right: [3])),
            [.left(0), .left(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [])),
            [.left(0), .left(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0])),
            [.common(0, 0), .left(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 1])),
            [.common(0, 0), .common(1, 1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 1, 2])),
            [.common(0, 0), .common(1, 1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 1, 2, 3])),
            [.common(0, 0), .common(1, 1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 1, 3])),
            [.common(0, 0), .common(1, 1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 2])),
            [.common(0, 0), .left(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 2, 3])),
            [.common(0, 0), .left(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [0, 3])),
            [.common(0, 0), .left(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [1])),
            [.left(0), .common(1, 1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [1, 2])),
            [.left(0), .common(1, 1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [1, 2, 3])),
            [.left(0), .common(1, 1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [1, 3])),
            [.left(0), .common(1, 1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [2])),
            [.left(0), .left(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [2, 3])),
            [.left(0), .left(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 2, 3], right: [3])),
            [.left(0), .left(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [0, 1, 2])),
            [.common(0, 0), .common(1, 1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [0, 1, 2, 3])),
            [.common(0, 0), .common(1, 1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [0, 2])),
            [.common(0, 0), .left(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [0, 2, 3])),
            [.common(0, 0), .left(1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [1, 2])),
            [.left(0), .common(1, 1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [1, 2, 3])),
            [.left(0), .common(1, 1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [2])),
            [.left(0), .left(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 1, 3], right: [2, 3])),
            [.left(0), .left(1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [0, 1])),
            [.common(0, 0), .right(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [0, 1, 2])),
            [.common(0, 0), .right(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [0, 1, 2, 3])),
            [.common(0, 0), .right(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [0, 1, 3])),
            [.common(0, 0), .right(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [1])),
            [.left(0), .right(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [1, 2])),
            [.left(0), .right(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [1, 2, 3])),
            [.left(0), .right(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2], right: [1, 3])),
            [.left(0), .right(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [0, 1])),
            [.common(0, 0), .right(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [0, 1, 2])),
            [.common(0, 0), .right(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [0, 1, 2, 3])),
            [.common(0, 0), .right(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [0, 1, 3])),
            [.common(0, 0), .right(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [1])),
            [.left(0), .right(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [1, 2])),
            [.left(0), .right(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [1, 2, 3])),
            [.left(0), .right(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 2, 3], right: [1, 3])),
            [.left(0), .right(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 3], right: [0, 1, 2])),
            [.common(0, 0), .right(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 3], right: [0, 1, 2, 3])),
            [.common(0, 0), .right(1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 3], right: [1, 2])),
            [.left(0), .right(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [0, 3], right: [1, 2, 3])),
            [.left(0), .right(1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0])),
            [.right(0), .left(1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0, 1])),
            [.right(0), .common(1, 1)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0, 1, 2])),
            [.right(0), .common(1, 1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0, 1, 2, 3])),
            [.right(0), .common(1, 1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0, 2])),
            [.right(0), .left(1), .right(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1], right: [0, 2, 3])),
            [.right(0), .left(1), .right(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0])),
            [.right(0), .left(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 1])),
            [.right(0), .common(1, 1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 1, 2])),
            [.right(0), .common(1, 1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 1, 2, 3])),
            [.right(0), .common(1, 1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 1, 3])),
            [.right(0), .common(1, 1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 2])),
            [.right(0), .left(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 2, 3])),
            [.right(0), .left(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2], right: [0, 3])),
            [.right(0), .left(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0])),
            [.right(0), .left(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 1])),
            [.right(0), .common(1, 1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 1, 2])),
            [.right(0), .common(1, 1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 1, 2, 3])),
            [.right(0), .common(1, 1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 1, 3])),
            [.right(0), .common(1, 1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 2])),
            [.right(0), .left(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 2, 3])),
            [.right(0), .left(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 2, 3], right: [0, 3])),
            [.right(0), .left(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 3], right: [0, 1, 2])),
            [.right(0), .common(1, 1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 3], right: [0, 1, 2, 3])),
            [.right(0), .common(1, 1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 3], right: [0, 2])),
            [.right(0), .left(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [1, 3], right: [0, 2, 3])),
            [.right(0), .left(1), .right(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2], right: [0, 1])),
            [.right(0), .right(1), .left(2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2], right: [0, 1, 2])),
            [.right(0), .right(1), .common(2, 2)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2], right: [0, 1, 2, 3])),
            [.right(0), .right(1), .common(2, 2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2], right: [0, 1, 3])),
            [.right(0), .right(1), .left(2), .right(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2, 3], right: [0, 1])),
            [.right(0), .right(1), .left(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2, 3], right: [0, 1, 2])),
            [.right(0), .right(1), .common(2, 2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2, 3], right: [0, 1, 2, 3])),
            [.right(0), .right(1), .common(2, 2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [2, 3], right: [0, 1, 3])),
            [.right(0), .right(1), .left(2), .common(3, 3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [3], right: [0, 1, 2])),
            [.right(0), .right(1), .right(2), .left(3)])
        
        XCTAssertEqual(
            Array(SortedDifference(left: [3], right: [0, 1, 2, 3])),
            [.right(0), .right(1), .right(2), .common(3, 3)])
    }
    
    func testCustomIdentifier() {
        struct Left {
            var leftID: ID
        }
        struct Right {
            var rightID: ID
        }
        
        let difference = SortedDifference(
            left: [Left(leftID: ID(value: "a")), Left(leftID: ID(value: "b"))],
            identifiedBy: { $0.leftID },
            right: [Right(rightID: ID(value: "a"))],
            identifiedBy: { $0.rightID })
        
        // Make changes equatable, without conforming Left and Right to
        // Equatable, so that the test runs with minimal requirements
        let changes = difference.map { change -> SortedDifferenceChange<ID, ID> in
            switch change {
            case let .left(left): return .left(left.leftID)
            case let .right(right): return .right(right.rightID)
            case let .common(left, right): return .common(left.leftID, right.rightID)
            }
        }
        
        XCTAssertEqual(changes, [
            .common(ID(value: "a"), ID(value: "a")),
            .left(ID(value: "b")),
        ])
    }
    
    func testIdentifiableConvenienceInitializer() {
        if #available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *) {
            struct Left: Identifiable {
                var id: Int
            }
            struct Right: Identifiable {
                var id: Int
            }
            
            let difference = SortedDifference(
                left: [Left(id: 0), Left(id: 1)],
                right: [Right(id: 0)])
            
            // Make changes equatable, without conforming Left and Right to
            // Equatable, so that the test runs with minimal requirements
            let changes = difference.map { change -> SortedDifferenceChange<Int, Int> in
                switch change {
                case let .left(left): return .left(left.id)
                case let .right(right): return .right(right.id)
                case let .common(left, right): return .common(left.id, right.id)
                }
            }
            
            XCTAssertEqual(changes, [
                .common(0, 0),
                .left(1),
            ])
        }
    }
    
    func testComparableConvenienceInitializer() {
        let difference = SortedDifference(
            left: [ID(value: "a"), ID(value: "b")],
            right: [ID(value: "a")])
        
        XCTAssertEqual(Array(difference), [
            .common(ID(value: "a"), ID(value: "a")),
            .left(ID(value: "b")),
        ])
    }
    
    static var allTests = [
        ("testSortedDifference", testSortedDifference),
        ("testCustomIdentifier", testCustomIdentifier),
        ("testIdentifiableConvenienceInitializer", testIdentifiableConvenienceInitializer),
        ("testComparableConvenienceInitializer", testComparableConvenienceInitializer),
    ]
}
