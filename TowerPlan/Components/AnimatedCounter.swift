import SwiftUI

struct AnimatedCounter: View {
    let value: Double
    let currency: String
    var font: Font = .tpBigAmount
    var color: Color = TP.text

    @State private var displayed: Double = 0

    var body: some View {
        Text(CurrencyFormatter.format(displayed, currency: currency))
            .font(font)
            .foregroundStyle(color)
            .contentTransition(.numericText())
            .onAppear { displayed = value }
            .onChange(of: value) { newVal in
                withAnimation(.easeOut(duration: 0.5)) { displayed = newVal }
            }
    }
}
