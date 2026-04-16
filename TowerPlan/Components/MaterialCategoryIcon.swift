import SwiftUI

struct MaterialCategoryIcon: View {
    let category: MaterialCategory
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: TP.radiusSm, style: .continuous)
                .fill(category.color.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: TP.radiusSm, style: .continuous)
                        .strokeBorder(category.color.opacity(0.4), lineWidth: 1)
                )
            Image(systemName: category.icon)
                .font(.system(size: size * 0.45, weight: .semibold))
                .foregroundStyle(category.color)
        }
        .frame(width: size, height: size)
    }
}
