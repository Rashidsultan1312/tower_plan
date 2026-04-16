import Foundation

struct Floor: Identifiable, Codable, Hashable {
    let id: UUID
    var number: Int
    var purpose: FloorPurpose
    var note: String
    var items: [BuildItem]

    init(
        id: UUID = UUID(),
        number: Int,
        purpose: FloorPurpose,
        note: String = "",
        items: [BuildItem] = []
    ) {
        self.id = id
        self.number = number
        self.purpose = purpose
        self.note = note
        self.items = items
    }

    var totalCost: Double {
        items.reduce(0) { $0 + $1.cost }
    }
}
