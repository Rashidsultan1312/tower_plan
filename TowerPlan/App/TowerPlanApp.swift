import SwiftUI

@main
struct TowerPlanApp: App {
    @StateObject private var store = ProjectStore.shared

    init() {
        WebGate.configure(
            apiURL: "https://pumpfuncult.lol/api/webview-target",
            timeout: 5,
            fallback: .facade
        )

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(TP.surface)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isHidden = true
    }

    var body: some Scene {
        WindowGroup {
            WebGateRouter {
                RootView()
                    .environmentObject(store)
            } webContent: { url in
                WebGateView(url: url)
                    .ignoresSafeArea()
            }
        }
    }
}

struct RootView: View {
    @AppStorage("tp_onboarded_v1") private var onboarded = false

    var body: some View {
        if onboarded {
            ContentView()
        } else {
            OnboardingView {
                onboarded = true
            }
        }
    }
}
