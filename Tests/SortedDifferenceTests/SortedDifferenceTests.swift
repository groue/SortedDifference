import XCTest
@testable import SortedDifference

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
    
    static var allTests = [
        ("testSortedDifference", testSortedDifference),
    ]
}
