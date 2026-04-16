import SwiftUI

struct ItemRow: View {
    let item: BuildItem
    let currency: String
    var showCategory: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            if showCategory {
                MaterialCategoryIcon(category: item.category, size: 28)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(item.name.isEmpty ? item.category.label : item.name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(TP.text)
                    .lineLimit(1)
                Text(quantityString)
                    .font(.tpMono)
                    .foregroundStyle(TP.textSecondary)
            }

            Spacer()

            Text(CurrencyFormatter.format(item.cost, currency: currency))
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(TP.text)
                .monospacedDigit()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }

    private var quantityString: String {
        let q = item.quantity.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", item.quantity)
            : String(format: "%.2f", item.quantity)
        let p = CurrencyFormatter.format(item.pricePerUnit, currency: currency)
        return "\(q) \(item.unit) × \(p)"
    }
}
