import Foundation

struct Project: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var location: String
    var targetFloors: Int
    var currency: String
    var createdAt: Date
    var floors: [Floor]

    init(
        id: UUID = UUID(),
        name: String,
        location: String = "",
        targetFloors: Int = 12,
        currency: String = "USD",
        createdAt: Date = Date(),
        floors: [Floor] = []
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.targetFloors = targetFloors
        self.currency = currency
        self.createdAt = createdAt
        self.floors = floors
    }

    var totalEstimate: Double {
        floors.flatMap(\.items).reduce(0) { $0 + $1.cost }
    }

    var completedFloors: Int { floors.count }

    var progress: Double {
        guard targetFloors > 0 else { return 0 }
        return min(1.0, Double(completedFloors) / Double(targetFloors))
    }

    var itemCount: Int {
        floors.reduce(0) { $0 + $1.items.count }
    }
}
