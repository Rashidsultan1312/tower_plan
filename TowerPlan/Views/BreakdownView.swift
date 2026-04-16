import SwiftUI

struct BreakdownView: View {
    @EnvironmentObject var store: ProjectStore

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()

            if let project = store.activeProject {
                ScrollView {
                    VStack(spacing: 14) {
                        let cats = store.categoryBreakdown()

                        VStack(alignment: .leading, spacing: 10) {
                            Text("MATERIAL MIX")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)

                            if cats.isEmpty {
                                empty(message: "NO DATA")
                            } else {
                                VStack(spacing: 14) {
                                    CategoryDonutChart(data: cats.map { ($0.0, $0.1) })
                                        .frame(maxWidth: .infinity)

                                    legend(data: cats, total: project.totalEstimate)
                                }
                                .padding(14)
                                .frame(maxWidth: .infinity)
                                .tpCard()
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("COST BY FLOOR")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)

                            if project.floors.isEmpty {
                                empty(message: "NO FLOORS")
                            } else {
                                VStack {
                                    CostBarChart(
                                        data: project.floors
                                            .sorted { $0.number < $1.number }
                                            .map { (label: "FL \($0.number)", value: $0.totalCost) }
                                    )
                                }
                                .padding(14)
                                .tpCard()
                            }
                        }

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
        }
    }

    private func legend(data: [(MaterialCategory, Double)], total: Double) -> some View {
        VStack(spacing: 6) {
            ForEach(Array(data.enumerated()), id: \.offset) { _, row in
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(row.0.color)
                        .frame(width: 10, height: 10)
                    Text(row.0.label.uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .kerning(0.5)
                        .foregroundStyle(TP.text)
                    Spacer()
                    let pct = total > 0 ? row.1 / total * 100 : 0
                    Text(String(format: "%.1f%%", pct))
                        .font(.tpMono)
                        .foregroundStyle(TP.textSecondary)
                    Text(CurrencyFormatter.formatShort(row.1))
                        .font(.tpMono)
                        .foregroundStyle(TP.text)
                        .frame(width: 50, alignment: .trailing)
                }
            }
        }
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
