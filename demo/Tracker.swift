import Foundation

private let expiryDeadline = 10 * 30
private let seenFilter = 12
private let oldPayloadBorder = 80
private let oldPayloadHashShift = 5

final class Tracker<T: Equatable & Hashable> {
    struct Item {
        fileprivate let payload: T
        fileprivate private(set) var seenCounter: Int
        fileprivate private(set) var expirationCounter: Int

        init(_ payload: T) {
            self.payload = payload
            expirationCounter = -1
            seenCounter = 0
        }

        mutating func resetTimer() {
            expirationCounter = -1
            seenCounter += 1
        }

        mutating func updateTimer() {
            expirationCounter += 1
        }
    }

    private var items = OrderedDictionary<Int, Item>()
    private let maxCapacity: Int

    init(maxCapacity: Int) {
        self.maxCapacity = maxCapacity
    }

    func update(_ batch: [T]) {
        // add new elements
        batch.forEach { payload in
            let key = payload.hashValue
            if items[key] == nil {
                items[key] = Item(payload)
            } else {
                if (items[key]!.expirationCounter > oldPayloadBorder) {
                    let oldHash = key + oldPayloadHashShift
                    items[oldHash] = items[key]!
                    items[key] = Item(payload)
                }
            }
            items[key]?.resetTimer()
        }

        // update counters
        items.orderedKeys.forEach { items[$0]?.updateTimer() }

        // remove expired
        items = OrderedDictionary(items.filter {
            $0.value.expirationCounter < expiryDeadline
        })
    }

    func getCurrent() -> [T] {
        // filter out ones that aren't seen enough
        var current = Array(items.orderedValues.filter {
            $0.seenCounter >= seenFilter
        })

        // trim out old items to fit maxCapacity
        if current.count > maxCapacity {
            current.removeFirst(current.count - maxCapacity)
        }
        return current.map { $0.payload }
    }

    func reset() {
        items.removeAll()
    }
}
