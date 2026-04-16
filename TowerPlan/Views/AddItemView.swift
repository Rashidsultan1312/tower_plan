import SwiftUI

struct AddItemView: View {
    let projectID: UUID
    let floorID: UUID
    @EnvironmentObject var store: ProjectStore
    @Environment(\.dismiss) var dismiss

    @State private var category: MaterialCategory = .concrete
    @State private var name = ""
    @State private var unit = ""
    @State private var quantity = ""
    @State private var price = ""

    var body: some View {
        NavigationStack {
            ZStack {
                TP.bgGrad.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("CATEGORY")
                                .font(.tpLabel)
                                .kerning(1.5)
                                .foregroundStyle(TP.textMuted)
                            MaterialPicker(selection: $category)
                        }
                        .onChange(of: category) { new in
                            if unit.isEmpty { unit = new.defaultUnit }
                        }

                        field(title: "NAME", text: $name, placeholder: category.label, keyboard: .default)

                        HStack(spacing: 10) {
                            field(title: "QTY", text: $quantity, placeholder: "0", keyboard: .decimalPad)
                            field(title: "UNIT", text: $unit, placeholder: category.defaultUnit, keyboard: .default)
                        }

                        field(title: "PRICE PER UNIT", text: $price, placeholder: "0", keyboard: .decimalPad)

                        totalPreview

                        Button { save() } label: {
                            Text("ADD ITEM").kerning(1.2)
                        }
                        .tpPrimaryButton()
                        .disabled(!canSave)
                        .opacity(canSave ? 1 : 0.5)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(TP.textSecondary)
                }
            }
            .onAppear {
                if unit.isEmpty { unit = category.defaultUnit }
            }
        }
    }

    private var canSave: Bool {
        (Double(quantity) ?? 0) > 0 && (Double(price) ?? 0) > 0
    }

    private var totalPreview: some View {
        let q = Double(quantity) ?? 0
        let p = Double(price) ?? 0
        let total = q * p
        let curr = store.projects.first(where: { $0.id == projectID })?.currency ?? "USD"
        return HStack {
            Text("TOTAL")
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            Spacer()
            Text(CurrencyFormatter.format(total, currency: curr))
                .font(.tpAmount)
                .foregroundStyle(TP.safety)
        }
        .padding(16)
        .background(TP.card)
        .overlay(
            RoundedRectangle(cornerRadius: TP.radiusSm)
                .strokeBorder(TP.safety.opacity(0.4), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
    }

    private func field(title: String, text: Binding<String>, placeholder: String, keyboard: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            TextField(placeholder, text: text)
                .keyboardType(keyboard)
                .font(.system(size: 15, weight: .medium).monospacedDigit())
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
        let item = BuildItem(
            category: category,
            name: name.isEmpty ? category.label : name,
            unit: unit.isEmpty ? category.defaultUnit : unit,
            quantity: Double(quantity) ?? 0,
            pricePerUnit: Double(price) ?? 0
        )
        store.addItem(item, to: floorID, in: projectID)
        dismiss()
    }
}
