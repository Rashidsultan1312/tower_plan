import SwiftUI

struct FloorBlock: View {
    let floor: Floor
    let currency: String
    var onAdd: () -> Void
    var onDelete: () -> Void

    @State private var expanded = false

    var body: some View {
        VStack(spacing: 0) {
            header
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) { expanded.toggle() }
                }

            if expanded {
                Divider().background(TP.divider)
                ForEach(floor.items) { item in
                    ItemRow(item: item, currency: currency)
                    Divider().background(TP.divider).opacity(0.5)
                }
                if floor.items.isEmpty {
                    Text("NO ITEMS")
                        .font(.tpLabel)
                        .foregroundStyle(TP.textMuted)
                        .kerning(1.5)
                        .padding(.vertical, 14)
                }
                HStack(spacing: 10) {
                    Button(action: onAdd) {
                        HStack(spacing: 6) {
                            Image(systemName: "plus")
                            Text("ADD ITEM").kerning(1.2)
                        }
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(TP.safety)

                    Spacer()

                    Button(action: onDelete) {
                        HStack(spacing: 6) {
                            Image(systemName: "trash")
                            Text("DELETE").kerning(1.2)
                        }
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(TP.danger)
                }
                .padding(.horizontal, 0)
                .padding(.vertical, 2)
            }
        }
        .tpCard()
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(spacing: 2) {
                Text("FL")
                    .font(.tpLabel)
                    .foregroundStyle(TP.textMuted)
                Text("\(floor.number)")
                    .font(.tpFloorNum)
                    .foregroundStyle(TP.safety)
            }
            .frame(width: 36)
            .padding(.vertical, 8)
            .background(TP.bgDeep)
            .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))

            FloorPurposeIcon(purpose: floor.purpose, size: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(floor.purpose.label.uppercased())
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(TP.text)
                Text("\(floor.items.count) items")
                    .font(.tpCaption)
                    .foregroundStyle(TP.textMuted)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(CurrencyFormatter.format(floor.totalCost, currency: currency))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(TP.text)
                    .monospacedDigit()
                Image(systemName: expanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(TP.textMuted)
            }
        }
        .padding(12)
    }
}
