import Foundation

struct BuildItem: Identifiable, Codable, Hashable {
    let id: UUID
    var category: MaterialCategory
    var name: String
    var unit: String
    var quantity: Double
    var pricePerUnit: Double
    var addedAt: Date

    init(
        id: UUID = UUID(),
        category: MaterialCategory,
        name: String,
        unit: String = "",
        quantity: Double = 1,
        pricePerUnit: Double = 0,
        addedAt: Date = Date()
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.unit = unit
        self.quantity = quantity
        self.pricePerUnit = pricePerUnit
        self.addedAt = addedAt
    }

    var cost: Double { quantity * pricePerUnit }
}
