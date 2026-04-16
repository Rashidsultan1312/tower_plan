import SwiftUI

struct FloorPurposeIcon: View {
    let purpose: FloorPurpose
    var size: CGFloat = 36

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: TP.radiusSm, style: .continuous)
                .fill(purpose.color.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: TP.radiusSm, style: .continuous)
                        .strokeBorder(purpose.color.opacity(0.4), lineWidth: 1)
                )
            Image(systemName: purpose.icon)
                .font(.system(size: size * 0.45, weight: .semibold))
                .foregroundStyle(purpose.color)
        }
        .frame(width: size, height: size)
    }
}
