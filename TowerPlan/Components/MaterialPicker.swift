import SwiftUI

struct MaterialPicker: View {
    @Binding var selection: MaterialCategory

    private let columns = [GridItem(.adaptive(minimum: 82), spacing: 10)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(MaterialCategory.allCases) { cat in
                Button {
                    selection = cat
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: cat.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(selection == cat ? TP.onSafety : cat.color)
                            .frame(width: 34, height: 34)
                            .background(
                                RoundedRectangle(cornerRadius: TP.radiusSm)
                                    .fill(selection == cat ? TP.safety : cat.color.opacity(0.12))
                            )
                        Text(cat.label.uppercased())
                            .font(.tpLabel)
                            .foregroundStyle(selection == cat ? TP.text : TP.textSecondary)
                            .kerning(0.8)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: TP.radius)
                            .fill(selection == cat ? TP.safety.opacity(0.1) : TP.card)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: TP.radius)
                            .strokeBorder(selection == cat ? TP.safety : TP.border, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct FloorPurposePicker: View {
    @Binding var selection: FloorPurpose

    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 10)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(FloorPurpose.allCases) { p in
                Button {
                    selection = p
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: p.icon)
                            .font(.system(size: 14))
                            .foregroundStyle(selection == p ? TP.onSafety : p.color)
                        Text(p.label.uppercased())
                            .font(.system(size: 11, weight: .bold))
                            .kerning(0.8)
                            .foregroundStyle(selection == p ? TP.onSafety : TP.text)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: TP.radiusSm)
                            .fill(selection == p ? TP.safety : TP.card)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: TP.radiusSm)
                            .strokeBorder(selection == p ? TP.safetyDark : TP.border, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}
