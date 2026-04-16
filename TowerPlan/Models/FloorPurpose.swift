import SwiftUI

enum FloorPurpose: String, Codable, CaseIterable, Identifiable {
    case foundation
    case parking
    case technical
    case residential
    case commercial
    case office
    case facade
    case roof

    var id: String { rawValue }

    var label: String {
        switch self {
        case .foundation:  return "Foundation"
        case .parking:     return "Parking"
        case .technical:   return "Technical"
        case .residential: return "Residential"
        case .commercial:  return "Commercial"
        case .office:      return "Office"
        case .facade:      return "Facade"
        case .roof:        return "Roof"
        }
    }

    var icon: String {
        switch self {
        case .foundation:  return "square.stack.3d.down.right.fill"
        case .parking:     return "car.fill"
        case .technical:   return "bolt.fill"
        case .residential: return "bed.double.fill"
        case .commercial:  return "bag.fill"
        case .office:      return "briefcase.fill"
        case .facade:      return "rectangle.grid.3x2.fill"
        case .roof:        return "triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .foundation:  return TP.concrete
        case .parking:     return TP.steel
        case .technical:   return TP.electrical
        case .residential: return TP.brick
        case .commercial:  return TP.glass
        case .office:      return TP.finishing
        case .facade:      return TP.insulation
        case .roof:        return TP.roofing
        }
    }
}
