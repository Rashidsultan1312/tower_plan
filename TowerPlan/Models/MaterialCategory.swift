import SwiftUI

enum MaterialCategory: String, Codable, CaseIterable, Identifiable {
    case concrete
    case steel
    case brick
    case glass
    case insulation
    case roofing
    case electrical
    case plumbing
    case hvac
    case finishing
    case labor
    case equipment
    case logistics
    case permits
    case other

    var id: String { rawValue }

    var label: String {
        switch self {
        case .concrete:   return "Concrete"
        case .steel:      return "Steel"
        case .brick:      return "Brick"
        case .glass:      return "Glass"
        case .insulation: return "Insulation"
        case .roofing:    return "Roofing"
        case .electrical: return "Electrical"
        case .plumbing:   return "Plumbing"
        case .hvac:       return "HVAC"
        case .finishing:  return "Finishing"
        case .labor:      return "Labor"
        case .equipment:  return "Equipment"
        case .logistics:  return "Logistics"
        case .permits:    return "Permits"
        case .other:      return "Other"
        }
    }

    var icon: String {
        switch self {
        case .concrete:   return "cube.fill"
        case .steel:      return "ruler.fill"
        case .brick:      return "square.grid.3x3.fill"
        case .glass:      return "square.on.square"
        case .insulation: return "thermometer.medium"
        case .roofing:    return "house.fill"
        case .electrical: return "bolt.fill"
        case .plumbing:   return "drop.fill"
        case .hvac:       return "wind"
        case .finishing:  return "paintbrush.fill"
        case .labor:      return "person.2.fill"
        case .equipment:  return "wrench.and.screwdriver.fill"
        case .logistics:  return "shippingbox.fill"
        case .permits:    return "doc.text.fill"
        case .other:      return "ellipsis"
        }
    }

    var defaultUnit: String {
        switch self {
        case .concrete:   return "m³"
        case .steel:      return "t"
        case .brick:      return "pcs"
        case .glass:      return "m²"
        case .insulation: return "m²"
        case .roofing:    return "m²"
        case .electrical: return "set"
        case .plumbing:   return "set"
        case .hvac:       return "set"
        case .finishing:  return "m²"
        case .labor:      return "h"
        case .equipment:  return "day"
        case .logistics:  return "trip"
        case .permits:    return "doc"
        case .other:      return "pcs"
        }
    }

    var color: Color {
        switch self {
        case .concrete:   return TP.concrete
        case .steel:      return TP.steel
        case .brick:      return TP.brick
        case .glass:      return TP.glass
        case .insulation: return TP.insulation
        case .roofing:    return TP.roofing
        case .electrical: return TP.electrical
        case .plumbing:   return TP.plumbing
        case .hvac:       return TP.hvac
        case .finishing:  return TP.finishing
        case .labor:      return TP.labor
        case .equipment:  return TP.equipment
        case .logistics:  return TP.logistics
        case .permits:    return TP.permits
        case .other:      return TP.textMuted
        }
    }
}
