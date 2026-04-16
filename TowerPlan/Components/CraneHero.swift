import SwiftUI

struct CraneHero: View {
    var floorsBuilt: Int
    var targetFloors: Int

    var body: some View {
        ZStack {
            TP.skyGrad
            sunRays
            crane
            hazardBase
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: TP.radiusLg))
        .overlay(
            RoundedRectangle(cornerRadius: TP.radiusLg)
                .strokeBorder(TP.hazardBlack, lineWidth: 2)
        )
    }

    private var sunRays: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(hex: 0xFDE47A).opacity(0.9), Color.clear],
                        center: .center, startRadius: 10, endRadius: 120
                    )
                )
                .frame(width: 240, height: 240)
                .offset(y: 70)
        }
    }

    private var crane: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(TP.hazardBlack)
                    .frame(width: 3, height: h * 0.6)
                    .position(x: w * 0.75, y: h * 0.3)

                Rectangle()
                    .fill(TP.hazardBlack)
                    .frame(width: w * 0.55, height: 3)
                    .position(x: w * 0.5, y: h * 0.12)

                Rectangle()
                    .fill(TP.hazardBlack)
                    .frame(width: 2, height: h * 0.35)
                    .position(x: w * 0.35, y: h * 0.3)

                brickBlock(count: maxi(floorsBuilt, 1))
                    .position(x: w * 0.35, y: h * 0.55)
            }
        }
    }

    private func brickBlock(count: Int) -> some View {
        let visible = minI(count, 5)
        return VStack(spacing: 2) {
            ForEach(0..<visible, id: \.self) { i in
                brickRow(offset: i)
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(TP.brick)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(TP.hazardBlack, lineWidth: 2)
        )
        .shadow(color: TP.hazardBlack.opacity(0.3), radius: 2, x: 1, y: 2)
    }

    private func brickRow(offset: Int) -> some View {
        HStack(spacing: 2) {
            if offset % 2 == 1 {
                Rectangle().fill(TP.brickLight).frame(width: 12, height: 10)
            }
            Rectangle().fill(TP.brickLight).frame(width: 24, height: 10)
            Rectangle().fill(TP.brickLight).frame(width: 24, height: 10)
            if offset % 2 == 0 {
                Rectangle().fill(TP.brickLight).frame(width: 12, height: 10)
            }
        }
    }

    private var hazardBase: some View {
        VStack {
            Spacer()
            HazardStripe(height: 10)
        }
    }

    private func minI(_ a: Int, _ b: Int) -> Int { a < b ? a : b }
    private func maxi(_ a: Int, _ b: Int) -> Int { a > b ? a : b }
}
