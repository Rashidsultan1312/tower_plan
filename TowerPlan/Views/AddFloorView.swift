import SwiftUI

struct AddFloorView: View {
    let projectID: UUID
    @EnvironmentObject var store: ProjectStore
    @Environment(\.dismiss) var dismiss

    @State private var number = ""
    @State private var purpose: FloorPurpose = .residential
    @State private var note = ""

    var body: some View {
        NavigationStack {
            ZStack {
                TP.bgGrad.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        field(title: "FLOOR NUMBER", text: $number, placeholder: suggestedNumber, keyboard: .numberPad)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("PURPOSE")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)
                            FloorPurposePicker(selection: $purpose)
                        }

                        field(title: "NOTE", text: $note, placeholder: "Optional", keyboard: .default)

                        Button { save() } label: {
                            Text("ADD FLOOR").kerning(1.2)
                        }
                        .tpPrimaryButton()
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Add Floor")
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

    private var suggestedNumber: String {
        guard let p = store.projects.first(where: { $0.id == projectID }) else { return "1" }
        let next = (p.floors.map(\.number).max() ?? 0) + 1
        return "\(next)"
    }

    private func field(title: String, text: Binding<String>, placeholder: String, keyboard: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            TextField(placeholder, text: text)
                .keyboardType(keyboard)
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

    private func save() {
        let num = Int(number) ?? (Int(suggestedNumber) ?? 1)
        let floor = Floor(number: num, purpose: purpose, note: note)
        store.addFloor(floor, to: projectID)
        dismiss()
    }
}
