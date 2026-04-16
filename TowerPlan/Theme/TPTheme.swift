import SwiftUI

enum TP {
    static let bg = Color(hex: 0x0F1B24)
    static let bgDeep = Color(hex: 0x08121A)
    static let surface = Color(hex: 0x1A2530)
    static let card = Color(hex: 0x22303C)
    static let cardElevated = Color(hex: 0x2A3B48)
    static let border = Color(hex: 0x33485A)
    static let borderLight = Color(hex: 0x4A6478)
    static let divider = Color(hex: 0x2C3E4E)

    static let safety = Color(hex: 0xF6A324)
    static let safetyBright = Color(hex: 0xFDD84A)
    static let safetyDark = Color(hex: 0xD08216)
    static let onSafety = Color(hex: 0x1A0F00)

    static let sky = Color(hex: 0x5BB4D6)
    static let skyBright = Color(hex: 0x8DD4E8)
    static let skyDeep = Color(hex: 0x2F7DE0)

    static let hazardYellow = Color(hex: 0xF6D200)
    static let hazardBlack = Color(hex: 0x1A1A1A)

    static let brick = Color(hex: 0xB85432)
    static let brickLight = Color(hex: 0xD26B43)

    static let text = Color(hex: 0xFFFDF5)
    static let textSecondary = Color(hex: 0xB8C4CE)
    static let textMuted = Color(hex: 0x6A7A86)
    static let textFaint = Color(hex: 0x3E4B56)

    static let ok = Color(hex: 0x56C978)
    static let warn = Color(hex: 0xF6D200)
    static let danger = Color(hex: 0xE8553D)

    static let concrete = Color(hex: 0x9FA8B0)
    static let steel = Color(hex: 0x5B7A99)
    static let glass = Color(hex: 0x6FB4C9)
    static let insulation = Color(hex: 0xFDD84A)
    static let roofing = Color(hex: 0x8D5842)
    static let electrical = Color(hex: 0xF6D200)
    static let plumbing = Color(hex: 0x4FA3C7)
    static let hvac = Color(hex: 0x8FB5B0)
    static let finishing = Color(hex: 0xE8A068)
    static let labor = Color(hex: 0xF6A324)
    static let equipment = Color(hex: 0xA67BBF)
    static let logistics = Color(hex: 0x6D8A5A)
    static let permits = Color(hex: 0xB8C4CE)

    static let radius: CGFloat = 12
    static let radiusSm: CGFloat = 8
    static let radiusLg: CGFloat = 18

    static let safetyGrad = LinearGradient(
        colors: [Color(hex: 0xFDD84A), Color(hex: 0xF6A324)],
        startPoint: .top, endPoint: .bottom
    )

    static let blueButtonGrad = LinearGradient(
        colors: [Color(hex: 0x4A9FF0), Color(hex: 0x2F7DE0)],
        startPoint: .top, endPoint: .bottom
    )

    static let cardGrad = LinearGradient(
        colors: [Color(hex: 0x2A3B48), Color(hex: 0x1A2530)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    static let bgGrad = LinearGradient(
        colors: [Color(hex: 0x16303F), Color(hex: 0x0A1620)],
        startPoint: .top, endPoint: .bottom
    )

    static let skyGrad = LinearGradient(
        colors: [Color(hex: 0x5BB4D6), Color(hex: 0x8DD4E8), Color(hex: 0xFDD84A)],
        startPoint: .top, endPoint: .bottom
    )
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

struct TPCardMod: ViewModifier {
    var elevated: Bool = false
    var bordered: Bool = true
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: TP.radius, style: .continuous)
                    .fill(elevated ? TP.cardElevated : TP.card)
            )
            .overlay(
                RoundedRectangle(cornerRadius: TP.radius, style: .continuous)
                    .strokeBorder(TP.border, lineWidth: bordered ? 1.5 : 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: TP.radius, style: .continuous))
    }
}

struct TPPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .heavy, design: .rounded))
            .foregroundStyle(TP.onSafety)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .background(TP.safetyGrad)
            .overlay(
                RoundedRectangle(cornerRadius: TP.radiusLg)
                    .strokeBorder(TP.hazardBlack, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: TP.radiusLg))
            .shadow(color: TP.safetyDark.opacity(0.4), radius: 0, x: 0, y: 3)
    }
}

struct TPBlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .heavy, design: .rounded))
            .foregroundStyle(Color.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .background(TP.blueButtonGrad)
            .overlay(
                RoundedRectangle(cornerRadius: TP.radius)
                    .strokeBorder(Color(hex: 0x1A4FA0), lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: TP.radius))
    }
}

struct TPSecondaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .foregroundStyle(TP.text)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .background(TP.card)
            .overlay(
                RoundedRectangle(cornerRadius: TP.radius)
                    .strokeBorder(TP.border, lineWidth: 1.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: TP.radius))
    }
}

struct HazardStripe: View {
    var height: CGFloat = 8
    var body: some View {
        GeometryReader { geo in
            Canvas { ctx, size in
                ctx.fill(Path(CGRect(origin: .zero, size: size)), with: .color(TP.hazardBlack))
                let stripe: CGFloat = 14
                var x: CGFloat = -size.height
                while x < size.width {
                    let p = Path { p in
                        p.move(to: CGPoint(x: x, y: 0))
                        p.addLine(to: CGPoint(x: x + stripe, y: 0))
                        p.addLine(to: CGPoint(x: x + stripe + size.height, y: size.height))
                        p.addLine(to: CGPoint(x: x + size.height, y: size.height))
                        p.closeSubpath()
                    }
                    ctx.fill(p, with: .color(TP.hazardYellow))
                    x += stripe * 2
                }
            }
            .frame(width: geo.size.width, height: height)
        }
        .frame(height: height)
    }
}

extension View {
    func tpCard(elevated: Bool = false, bordered: Bool = true) -> some View {
        modifier(TPCardMod(elevated: elevated, bordered: bordered))
    }
    func tpPrimaryButton() -> some View { modifier(TPPrimaryButton()) }
    func tpBlueButton() -> some View { modifier(TPBlueButton()) }
    func tpSecondaryButton() -> some View { modifier(TPSecondaryButton()) }
}

extension Font {
    static let tpTitle    = Font.system(size: 24, weight: .heavy, design: .rounded)
    static let tpH2       = Font.system(size: 19, weight: .heavy, design: .rounded)
    static let tpH3       = Font.system(size: 16, weight: .bold, design: .rounded)
    static let tpBody     = Font.system(size: 14, weight: .medium, design: .rounded)
    static let tpCaption  = Font.system(size: 12, weight: .semibold, design: .rounded)
    static let tpLabel    = Font.system(size: 10, weight: .heavy, design: .rounded)
    static let tpAmount   = Font.system(size: 30, weight: .black, design: .rounded).monospacedDigit()
    static let tpBigAmount = Font.system(size: 40, weight: .black, design: .rounded).monospacedDigit()
    static let tpMono     = Font.system(size: 12, weight: .bold, design: .rounded).monospacedDigit()
    static let tpFloorNum = Font.system(size: 15, weight: .black, design: .rounded).monospacedDigit()
}

struct CurrencyFormatter {
    static func format(_ amount: Double, currency: String) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        f.maximumFractionDigits = 0
        f.minimumFractionDigits = 0
        return f.string(from: NSNumber(value: amount)) ?? "\(Int(amount))"
    }

    static func formatShort(_ amount: Double) -> String {
        let abs = Swift.abs(amount)
        if abs >= 1_000_000 {
            return String(format: "%.1fM", amount / 1_000_000)
        } else if abs >= 1_000 {
            return String(format: "%.1fK", amount / 1_000)
        }
        return String(format: "%.0f", amount)
    }
}
