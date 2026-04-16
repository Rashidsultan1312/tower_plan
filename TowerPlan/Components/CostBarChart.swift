import SwiftUI

struct CostBarChart: View {
    let data: [(label: String, value: Double)]
    var barColor: Color = TP.safety
    var formatter: (Double) -> String = { CurrencyFormatter.formatShort($0) }

    private var maxValue: Double {
        max(data.map { $0.value }.max() ?? 1, 1)
    }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(Array(data.enumerated()), id: \.offset) { _, item in
                HStack(spacing: 10) {
                    Text(item.label)
                        .font(.tpLabel)
                        .foregroundStyle(TP.textSecondary)
                        .kerning(1)
                        .frame(width: 52, alignment: .leading)

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(TP.bgDeep)
                                .frame(height: 18)
                            RoundedRectangle(cornerRadius: 2)
                                .fill(barColor)
                                .frame(width: geo.size.width * CGFloat(item.value / maxValue), height: 18)
                        }
                    }
                    .frame(height: 18)

                    Text(formatter(item.value))
                        .font(.tpMono)
                        .foregroundStyle(TP.text)
                        .frame(width: 60, alignment: .trailing)
                }
            }
        }
    }
}

struct CategoryDonutChart: View {
    let data: [(category: MaterialCategory, value: Double)]
    var size: CGFloat = 180

    private var total: Double {
        max(data.map { $0.value }.reduce(0, +), 0.0001)
    }

    var body: some View {
        ZStack {
            ForEach(Array(segments.enumerated()), id: \.offset) { _, seg in
                Circle()
                    .trim(from: seg.start, to: seg.end)
                    .stroke(seg.color, lineWidth: 22)
                    .rotationEffect(.degrees(-90))
            }

            VStack(spacing: 2) {
                Text("TOTAL")
                    .font(.tpLabel)
                    .foregroundStyle(TP.textMuted)
                    .kerning(1.2)
                Text(CurrencyFormatter.formatShort(total))
                    .font(.system(size: 20, weight: .heavy).monospacedDigit())
                    .foregroundStyle(TP.safety)
            }
        }
        .frame(width: size, height: size)
        .padding(16)
    }

    private var segments: [(start: CGFloat, end: CGFloat, color: Color)] {
        var result: [(CGFloat, CGFloat, Color)] = []
        var running: CGFloat = 0
        for d in data {
            let frac = CGFloat(d.value / total)
            result.append((running, running + frac, d.category.color))
            running += frac
        }
        return result
    }
}
