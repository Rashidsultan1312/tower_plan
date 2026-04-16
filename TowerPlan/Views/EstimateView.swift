import SwiftUI

struct EstimateView: View {
    @EnvironmentObject var store: ProjectStore

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()

            if let project = store.activeProject {
                ScrollView {
                    VStack(spacing: 14) {
                        totalCard(project: project)

                        sectionTitle("BY FLOOR")

                        if project.floors.isEmpty {
                            empty(message: "NO DATA")
                        } else {
                            floorsTable(project: project)
                        }

                        sectionTitle("BY CATEGORY")

                        let cats = store.categoryBreakdown()
                        if cats.isEmpty {
                            empty(message: "NO ITEMS")
                        } else {
                            categoryTable(data: cats, currency: project.currency, total: project.totalEstimate)
                        }

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
        }
    }

    private func totalCard(project: Project) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TOTAL ESTIMATE")
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            Text(CurrencyFormatter.format(project.totalEstimate, currency: project.currency))
                .font(.tpBigAmount)
                .foregroundStyle(TP.safety)
            HazardStripe(height: 3)
                .padding(.top, 6)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .tpCard()
    }

    private func sectionTitle(_ text: String) -> some View {
        HStack {
            Text(text)
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            Spacer()
            Rectangle().fill(TP.border).frame(height: 1)
        }
        .padding(.top, 4)
    }

    private func floorsTable(project: Project) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text("FL").font(.tpLabel).foregroundStyle(TP.textMuted).frame(width: 32, alignment: .leading)
                Text("PURPOSE").font(.tpLabel).foregroundStyle(TP.textMuted)
                Spacer()
                Text("ITEMS").font(.tpLabel).foregroundStyle(TP.textMuted).frame(width: 50, alignment: .trailing)
                Text("TOTAL").font(.tpLabel).foregroundStyle(TP.textMuted).frame(width: 80, alignment: .trailing)
            }
            .kerning(1.2)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(TP.bgDeep)

            ForEach(project.floors.sorted { $0.number > $1.number }) { floor in
                Divider().background(TP.divider)
                HStack {
                    Text("\(floor.number)")
                        .font(.tpFloorNum)
                        .foregroundStyle(TP.safety)
                        .frame(width: 32, alignment: .leading)
                    HStack(spacing: 6) {
                        Image(systemName: floor.purpose.icon)
                            .font(.system(size: 11))
                            .foregroundStyle(floor.purpose.color)
                        Text(floor.purpose.label)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(TP.text)
                    }
                    Spacer()
                    Text("\(floor.items.count)")
                        .font(.tpMono)
                        .foregroundStyle(TP.textSecondary)
                        .frame(width: 50, alignment: .trailing)
                    Text(CurrencyFormatter.formatShort(floor.totalCost))
                        .font(.tpMono)
                        .foregroundStyle(TP.text)
                        .frame(width: 80, alignment: .trailing)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
            }
        }
        .tpCard()
    }

    private func categoryTable(data: [(MaterialCategory, Double)], currency: String, total: Double) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(data.enumerated()), id: \.offset) { idx, row in
                if idx > 0 { Divider().background(TP.divider) }
                let pct = total > 0 ? row.1 / total * 100 : 0
                HStack(spacing: 12) {
                    MaterialCategoryIcon(category: row.0, size: 30)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(row.0.label.uppercased())
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(TP.text)
                            .kerning(0.5)
                        Text(String(format: "%.1f%%", pct))
                            .font(.tpMono)
                            .foregroundStyle(TP.textSecondary)
                    }
                    Spacer()
                    Text(CurrencyFormatter.format(row.1, currency: currency))
                        .font(.system(size: 13, weight: .bold).monospacedDigit())
                        .foregroundStyle(TP.text)
                }
                .padding(12)
            }
        }
        .tpCard()
    }

    private func empty(message: String) -> some View {
        Text(message)
            .font(.tpLabel)
            .kerning(1.5)
            .foregroundStyle(TP.textMuted)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 30)
            .tpCard()
    }
}
