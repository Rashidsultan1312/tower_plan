import SwiftUI

struct EstimateCard: View {
    let project: Project

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("PROJECT")
                        .font(.tpLabel)
                        .foregroundStyle(TP.textMuted)
                        .kerning(1.5)
                    Text(project.name.uppercased())
                        .font(.tpH2)
                        .foregroundStyle(TP.text)
                }
                Spacer()
                ProgressBadge(value: project.progress)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            Divider()
                .background(TP.divider)
                .padding(.top, 14)

            VStack(alignment: .leading, spacing: 6) {
                Text("TOTAL ESTIMATE")
                    .font(.tpLabel)
                    .foregroundStyle(TP.textMuted)
                    .kerning(1.5)
                AnimatedCounter(
                    value: project.totalEstimate,
                    currency: project.currency,
                    font: .tpBigAmount,
                    color: TP.safety
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            HazardStripe(height: 3)

            HStack(spacing: 0) {
                StatCell(label: "FLOORS", value: "\(project.completedFloors)/\(project.targetFloors)")
                Divider().background(TP.divider)
                StatCell(label: "ITEMS", value: "\(project.itemCount)")
                Divider().background(TP.divider)
                StatCell(label: "CURRENCY", value: project.currency)
            }
            .frame(height: 46)
        }
        .tpCard()
    }
}

private struct StatCell: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.tpLabel)
                .foregroundStyle(TP.textMuted)
                .kerning(1.2)
            Text(value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(TP.text)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProgressBadge: View {
    let value: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(TP.border, lineWidth: 3)
                .frame(width: 40, height: 40)
            Circle()
                .trim(from: 0, to: value)
                .stroke(TP.safety, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
            Text("\(Int(value * 100))")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(TP.text)
        }
    }
}
