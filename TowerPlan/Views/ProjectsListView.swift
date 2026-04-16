import SwiftUI

struct ProjectsListView: View {
    @EnvironmentObject var store: ProjectStore
    @Environment(\.dismiss) var dismiss
    @State private var showCreate = false

    var body: some View {
        NavigationStack {
            ZStack {
                TP.bgGrad.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(store.projects) { project in
                            projectRow(project)
                        }

                        if store.projects.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "building.2.fill")
                                    .font(.system(size: 48, weight: .light))
                                    .foregroundStyle(TP.textMuted)
                                Text("NO PROJECTS YET")
                                    .font(.tpLabel)
                                    .kerning(1.5)
                                    .foregroundStyle(TP.textMuted)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 60)
                        }

                        Button { showCreate = true } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus")
                                Text("NEW PROJECT").kerning(1.2)
                            }
                        }
                        .tpPrimaryButton()
                        .padding(.top, 8)
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Projects")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(TP.textSecondary)
                }
            }
            .sheet(isPresented: $showCreate) {
                NewProjectView()
                    .environmentObject(store)
            }
        }
    }

    private func projectRow(_ project: Project) -> some View {
        Button {
            store.selectProject(project.id)
            dismiss()
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: TP.radiusSm)
                        .fill(TP.safety.opacity(0.12))
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(TP.safety)
                }
                .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 3) {
                    Text(project.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(TP.text)
                    Text("\(project.completedFloors)/\(project.targetFloors) floors · \(project.itemCount) items")
                        .font(.tpCaption)
                        .foregroundStyle(TP.textSecondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 3) {
                    Text(CurrencyFormatter.format(project.totalEstimate, currency: project.currency))
                        .font(.system(size: 13, weight: .bold).monospacedDigit())
                        .foregroundStyle(TP.safety)
                    if store.activeProjectID == project.id {
                        Text("ACTIVE")
                            .font(.tpLabel)
                            .kerning(1)
                            .foregroundStyle(TP.ok)
                    }
                }
            }
            .padding(12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .tpCard()
        .overlay(
            RoundedRectangle(cornerRadius: TP.radius)
                .strokeBorder(store.activeProjectID == project.id ? TP.safety.opacity(0.6) : Color.clear, lineWidth: 1.5)
        )
        .contextMenu {
            Button(role: .destructive) {
                store.deleteProject(project.id)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct NewProjectView: View {
    @EnvironmentObject var store: ProjectStore
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var location = ""
    @State private var targetFloors = "12"
    @State private var currency = "USD"

    private let currencies = ["USD", "EUR", "GBP", "RUB", "CAD", "AUD", "JPY", "CHF", "PLN", "INR"]

    var body: some View {
        NavigationStack {
            ZStack {
                TP.bgGrad.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        field(title: "PROJECT NAME", text: $name, placeholder: "Tower A")
                        field(title: "LOCATION", text: $location, placeholder: "Optional")

                        VStack(alignment: .leading, spacing: 6) {
                            Text("TARGET FLOORS")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)
                            TextField("12", text: $targetFloors)
                                .keyboardType(.numberPad)
                                .font(.tpMono)
                                .foregroundStyle(TP.text)
                                .padding(12)
                                .background(TP.card)
                                .overlay(
                                    RoundedRectangle(cornerRadius: TP.radiusSm)
                                        .strokeBorder(TP.border, lineWidth: 1)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text("CURRENCY")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(currencies, id: \.self) { c in
                                        Button { currency = c } label: {
                                            Text(c)
                                                .font(.tpMono)
                                                .foregroundStyle(currency == c ? TP.onSafety : TP.text)
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 8)
                                                .background(currency == c ? TP.safety : TP.card)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: TP.radiusSm)
                                                        .strokeBorder(TP.border, lineWidth: 1)
                                                )
                                                .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }

                        Button {
                            createProject()
                        } label: {
                            Text("CREATE").kerning(1.2)
                        }
                        .tpPrimaryButton()
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                        .opacity(name.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1)
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("New Project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(TP.textSecondary)
                }
            }
        }
    }

    private func field(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            TextField(placeholder, text: text)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(TP.text)
                .padding(12)
                .background(TP.card)
                .overlay(
                    RoundedRectangle(cornerRadius: TP.radiusSm)
                        .strokeBorder(TP.border, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
        }
    }

    private func createProject() {
        let floors = Int(targetFloors) ?? 12
        let p = Project(
            name: name.trimmingCharacters(in: .whitespaces),
            location: location,
            targetFloors: max(1, floors),
            currency: currency
        )
        store.addProject(p)
        dismiss()
    }
}
