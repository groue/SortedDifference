// Copyright (C) 2019 Gwendal Roué
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

/// Given two sequences (left and right), this sequence tells whether elements
/// are only found on the left, on the right, or on both sides.
///
/// Both input sequences do not have to share the same element type. Yet their
/// elements must share a common comparable id.
///
/// Both input sequences must be sorted by this id.
///
/// Those ids must be unique in each sequences.
///
/// When elements adopt the Comparable protocol, elements are considered their
/// own id.
///
/// The example below compare two sorted sequences of integers:
///
///     // Prints:
///     // - Left: 1
///     // - Common: 2
///     // - Common: 3
///     // - Right: 4
///     for change in SortedDifference(
///         left: [1, 2, 3],
///         right: [2, 3, 4])
///     {
///         switch change {
///         case let .left(left):
///             print("- Left: \(left)")
///         case let .right(right):
///             print("- Right: \(right)")
///         case let .common(common, _):
///             print("- Common: \(common)")
///         }
///     }
public struct SortedDifference<LeftSequence, RightSequence, ID>: Sequence where
    LeftSequence: Sequence,
    RightSequence: Sequence,
    ID: Comparable
{
    private let left: LeftSequence
    private let right: RightSequence
    private let lID: (LeftSequence.Element) -> ID
    private let rID: (RightSequence.Element) -> ID
    
    /// Given two sequences (left and right), this sequence tells whether
    /// elements are only found on the left, on the right, or on both sides.
    ///
    /// Both input sequences do not have to share the same element type. Yet
    /// their elements must share a common comparable id.
    ///
    /// Both input sequences must be sorted by this id.
    ///
    /// Those ids must be unique in each sequences.
    ///
    /// The example below compare two sequences of integers:
    ///
    ///     // Prints:
    ///     // - Left: 1
    ///     // - Common: 2
    ///     // - Common: 3
    ///     // - Right: 4
    ///     for change in SortedDifference(
    ///         left: [1, 2, 3],
    ///         identifiedBy: { $0 },
    ///         right: [2, 3, 4],
    ///         identifiedBy: { $0 })
    ///     {
    ///         switch change {
    ///         case let .left(left):
    ///             print("- Left: \(left)")
    ///         case let .right(right):
    ///             print("- Right: \(right)")
    ///         case let .common(left, right):
    ///             print("- Common: \(left)")
    ///         }
    ///     }
    ///
    /// - parameters:
    ///     - left: The left sequence.
    ///     - right: The right sequence.
    ///     - leftID: A function that returns the id of a left element.
    ///     - rightID: A function that returns the id of a right element.
    public init(
        left: LeftSequence,
        identifiedBy leftID: @escaping (LeftSequence.Element) -> ID,
        right: RightSequence,
        identifiedBy rightID: @escaping (RightSequence.Element) -> ID)
    {
        self.left = left
        self.right = right
        self.lID = leftID
        self.rID = rightID
    }
    
    public func makeIterator() -> Iterator {
        Iterator(
            lIterator: left.makeIterator(),
            rIterator: right.makeIterator(),
            lID: lID,
            rID: rID)
    }
    
    public struct Iterator: IteratorProtocol {
        private var lIterator: LeftSequence.Iterator
        private var rIterator: RightSequence.Iterator
        private var lOpt: LeftSequence.Element?
        private var rOpt: RightSequence.Element?
        private let lID: (LeftSequence.Element) -> ID
        private let rID: (RightSequence.Element) -> ID
        
        init(
            lIterator: LeftSequence.Iterator,
            rIterator: RightSequence.Iterator,
            lID: @escaping (LeftSequence.Element) -> ID,
            rID: @escaping (RightSequence.Element) -> ID)
        {
            self.lIterator = lIterator
            self.rIterator = rIterator
            self.lID = lID
            self.rID = rID
            self.lOpt = self.lIterator.next()
            self.rOpt = self.rIterator.next()
        }
        
        public mutating func next() -> SortedDifferenceChange<LeftSequence.Element, RightSequence.Element>? {
            switch (lOpt, rOpt) {
            case let (lElem?, rElem?):
                let (lID, rID) = (self.lID(lElem), self.rID(rElem))
                if lID > rID {
                    rOpt = rIterator.next()
                    return .right(rElem)
                } else if lID == rID {
                    (lOpt, rOpt) = (lIterator.next(), rIterator.next())
                    return .common(lElem, rElem)
                } else {
                    lOpt = lIterator.next()
                    return .left(lElem)
                }
            case let (nil, rElem?):
                rOpt = rIterator.next()
                return .right(rElem)
            case let (lElem?, nil):
                lOpt = lIterator.next()
                return .left(lElem)
            case (nil, nil):
                return nil
            }
        }
    }
}

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension SortedDifference where
    LeftSequence.Element: Identifiable,
    RightSequence.Element: Identifiable,
    LeftSequence.Element.ID == ID,
    RightSequence.Element.ID == ID
{
    /// Given two sequences (left and right), this sequence tells whether
    /// elements are only found on the left, on the right, or on both sides.
    ///
    /// Both input sequences do not have to share the same element type. Yet
    /// their elements must share a common comparable id.
    ///
    /// Both input sequences must be sorted by this id.
    ///
    /// Those ids must be unique in each sequences.
    ///
    /// - parameters:
    ///     - left: The left sequence.
    ///     - right: The right sequence.
    public init(left: LeftSequence, right: RightSequence) {
        self.init(
            left: left,
            identifiedBy: { $0.id },
            right: right,
            identifiedBy: { $0.id })
    }
}

extension SortedDifference where
    LeftSequence.Element: Comparable,
    RightSequence.Element == LeftSequence.Element,
    LeftSequence.Element == ID
{
    /// Given two sequences (left and right), this sequence tells whether
    /// elements are only found on the left, on the right, or on both sides.
    ///
    /// Both input sequences must be sorted, and contain unique elements.
    ///
    /// The example below compare two sorted sequences of integers:
    ///
    ///     // Prints:
    ///     // - Left: 1
    ///     // - Common: 2
    ///     // - Common: 3
    ///     // - Right: 4
    ///     for change in SortedDifference(
    ///         left: [1, 2, 3],
    ///         right: [2, 3, 4])
    ///     {
    ///         switch change {
    ///         case let .left(left):
    ///             print("- Left: \(left)")
    ///         case let .right(right):
    ///             print("- Right: \(right)")
    ///         case let .common(common, _):
    ///             print("- Common: \(common)")
    ///         }
    ///     }
    ///
    /// - parameters:
    ///     - left: The left sequence.
    ///     - right: The right sequence.
    public init(left: LeftSequence, right: RightSequence) {
        self.init(
            left: left,
            identifiedBy: { $0 },
            right: right,
            identifiedBy: { $0 })
    }
}

/// An element of the SortedDifference sequence.
public enum SortedDifferenceChange<Left, Right> {
    /// An element only found in the left sequence
    case left(Left)
    /// An element only found in the right sequence
    case right(Right)
    /// Left and right elements share a common id
    case common(Left, Right)
}

extension SortedDifferenceChange: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .left(lhs):
            return "left(\(String(describing: lhs)))"
        case let .right(rhs):
            return "right(\(String(describing: rhs)))"
        case let .common(lhs, rhs):
            return "common(\(String(describing: lhs)), \(String(describing: rhs)))"
        }
    }
}

extension SortedDifferenceChange: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .left(lhs):
            return "left(\(String(reflecting: lhs)))"
        case let .right(rhs):
            return "right(\(String(reflecting: rhs)))"
        case let .common(lhs, rhs):
            return "common(\(String(reflecting: lhs)), \(String(reflecting: rhs)))"
        }
    }
}

extension SortedDifferenceChange: Equatable where
    Left: Equatable,
    Right: Equatable
{ }
