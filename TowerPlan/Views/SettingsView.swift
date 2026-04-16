import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: ProjectStore
    @State private var showReset = false
    @State private var showPrivacy = false

    var body: some View {
        NavigationStack {
            ZStack {
                TP.bgGrad.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        sectionTitle("PROJECT")
                        projectSection

                        sectionTitle("DATA")
                        dataSection

                        sectionTitle("ABOUT")
                        aboutSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .alert("Reset All Data?", isPresented: $showReset) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) { store.resetAll() }
            } message: {
                Text("This will permanently delete all projects, floors, and items. This cannot be undone.")
            }
            .sheet(isPresented: $showPrivacy) {
                NavigationStack { PrivacyPolicyView() }
            }
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.tpLabel)
            .foregroundStyle(TP.textMuted)
            .kerning(1.5)
            .padding(.horizontal, 4)
    }

    private var projectSection: some View {
        VStack(spacing: 0) {
            row(icon: "building.2.fill",
                label: "Active Project",
                value: store.activeProject?.name ?? "None",
                iconColor: TP.safety)
            Divider().background(TP.divider)
            row(icon: "number",
                label: "Total Projects",
                value: "\(store.projects.count)",
                iconColor: TP.steel)
            Divider().background(TP.divider)
            row(icon: "dollarsign.circle.fill",
                label: "Currency",
                value: store.activeProject?.currency ?? "—",
                iconColor: TP.electrical)
        }
        .tpCard()
    }

    private var dataSection: some View {
        Button(role: .destructive) {
            showReset = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "trash.fill")
                    .font(.system(size: 14))
                    .frame(width: 28, height: 28)
                    .foregroundStyle(TP.danger)
                Text("Reset All Data")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(TP.danger)
                Spacer()
            }
            .padding(12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .tpCard()
    }

    private var aboutSection: some View {
        VStack(spacing: 0) {
            Button { showPrivacy = true } label: {
                row(icon: "hand.raised.fill",
                    label: "Privacy Policy",
                    value: "",
                    iconColor: TP.steel,
                    showChevron: true)
            }
            .buttonStyle(.plain)
            Divider().background(TP.divider)
            row(icon: "info.circle.fill",
                label: "Version",
                value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
                iconColor: TP.concrete)
            Divider().background(TP.divider)
            row(icon: "envelope.fill",
                label: "Support",
                value: "dubskmak12@icloud.com",
                iconColor: TP.sky)
            Divider().background(TP.divider)
            row(icon: "hammer.fill",
                label: "Tower Plan",
                value: "Construction Estimator",
                iconColor: TP.safety)
        }
        .tpCard()
    }

    private func row(icon: String, label: String, value: String, iconColor: Color, showChevron: Bool = false) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .frame(width: 28, height: 28)
                .foregroundStyle(iconColor)
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(TP.text)
            Spacer()
            if !value.isEmpty {
                Text(value)
                    .font(.tpMono)
                    .foregroundStyle(TP.textSecondary)
            }
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(TP.textMuted)
            }
        }
        .padding(12)
        .contentShape(Rectangle())
    }
}
