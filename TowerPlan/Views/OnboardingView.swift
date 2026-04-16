import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void
    @State private var page = 0

    private let pages: [(icon: String, title: String, desc: String)] = [
        ("building.2.fill", "PLAN YOUR TOWER", "Create a project, set the target number of floors, define scope and currency"),
        ("square.stack.3d.up.fill", "STACK FLOORS", "Add floors bottom-up. Mark each by purpose: foundation, residential, commercial, roof"),
        ("doc.text.magnifyingglass", "GET THE ESTIMATE", "Track every material and work item. See the total cost broken down by category and floor"),
    ]

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()

            VStack(spacing: 0) {
                TabView(selection: $page) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { idx, p in
                        pageView(icon: p.icon, title: p.title, desc: p.desc)
                            .tag(idx)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))

                bottomSection
                    .padding(.bottom, 40)
            }
        }
    }

    private func pageView(icon: String, title: String, desc: String) -> some View {
        VStack(spacing: 28) {
            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: TP.radiusLg)
                    .strokeBorder(TP.safety, lineWidth: 2)
                    .frame(width: 130, height: 130)
                    .overlay(
                        RoundedRectangle(cornerRadius: TP.radiusLg)
                            .fill(TP.safety.opacity(0.08))
                    )
                Image(systemName: icon)
                    .font(.system(size: 56, weight: .light))
                    .foregroundStyle(TP.safety)
            }

            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 22, weight: .heavy))
                    .kerning(1.5)
                    .foregroundStyle(TP.text)
                    .multilineTextAlignment(.center)

                Text(desc)
                    .font(.tpBody)
                    .foregroundStyle(TP.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
            Spacer()
        }
    }

    private var bottomSection: some View {
        VStack(spacing: 16) {
            Button {
                if page == pages.count - 1 {
                    onComplete()
                } else {
                    withAnimation { page += 1 }
                }
            } label: {
                Text(page == pages.count - 1 ? "GET STARTED" : "NEXT")
                    .kerning(1.2)
            }
            .tpPrimaryButton()
            .padding(.horizontal, 32)

            if page < pages.count - 1 {
                Button { onComplete() } label: {
                    Text("SKIP")
                        .font(.tpLabel)
                        .kerning(1.2)
                        .foregroundStyle(TP.textMuted)
                }
            }
        }
    }
}
