import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: ProjectStore
    @AppStorage("tp_tab_v1") private var tab = 0
    @State private var showProjectsList = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TP.bgGrad
                .ignoresSafeArea()

            Group {
                if store.activeProject == nil {
                    EmptyStateView {
                        showProjectsList = true
                    }
                } else {
                    switch tab {
                    case 0: ProjectView()
                    case 1: EstimateView()
                    case 2: BreakdownView()
                    case 3: ItemsListView()
                    case 4: SettingsView()
                    default: ProjectView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 68)

            if store.activeProject != nil {
                bottomBar
            }
        }
        .ignoresSafeArea(.keyboard)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showProjectsList) {
            ProjectsListView()
                .environmentObject(store)
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 0) {
            tabBtn(icon: "building.2.fill", label: "PROJECT", tag: 0)
            tabBtn(icon: "doc.text.magnifyingglass", label: "ESTIMATE", tag: 1)
            tabBtn(icon: "chart.pie.fill", label: "BREAKDOWN", tag: 2)
            tabBtn(icon: "list.bullet.rectangle", label: "ITEMS", tag: 3)
            tabBtn(icon: "gearshape.fill", label: "SETTINGS", tag: 4)
        }
        .padding(.top, 10)
        .padding(.bottom, 4)
        .background(
            TP.surface
                .overlay(alignment: .top) {
                    Rectangle().fill(TP.border).frame(height: 1)
                }
                .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabBtn(icon: String, label: String, tag: Int) -> some View {
        Button { tab = tag } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 17))
                Text(label)
                    .font(.tpLabel)
            }
            .foregroundStyle(tab == tag ? TP.safety : TP.textMuted)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct EmptyStateView: View {
    var onCreate: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "building.2.fill")
                .font(.system(size: 56, weight: .light))
                .foregroundStyle(TP.safety)

            Text("NO ACTIVE PROJECT")
                .font(.tpLabel)
                .foregroundStyle(TP.textSecondary)
                .kerning(2)

            Text("Create your first tower project to start planning the construction estimate")
                .font(.tpBody)
                .foregroundStyle(TP.textMuted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button(action: onCreate) {
                Text("CREATE PROJECT")
                    .kerning(1.2)
            }
            .tpPrimaryButton()
            .padding(.horizontal, 40)
            .padding(.top, 12)

            Spacer()
        }
    }
}
