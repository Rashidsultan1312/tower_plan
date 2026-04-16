import SwiftUI

struct ItemsListView: View {
    @EnvironmentObject var store: ProjectStore
    @State private var filterCategory: MaterialCategory?

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()

            if let project = store.activeProject {
                ScrollView {
                    VStack(spacing: 14) {
                        Text("ALL ITEMS")
                            .font(.tpLabel)
                            .kerning(1.5)
                            .foregroundStyle(TP.textMuted)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        filterBar

                        let entries = store.allItems().filter {
                            filterCategory == nil || $0.item.category == filterCategory
                        }

                        if entries.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "tray")
                                    .font(.system(size: 36, weight: .light))
                                    .foregroundStyle(TP.textMuted)
                                Text("NO ITEMS")
                                    .font(.tpLabel)
                                    .kerning(1.5)
                                    .foregroundStyle(TP.textMuted)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .tpCard()
                        } else {
                            VStack(spacing: 0) {
                                ForEach(Array(entries.enumerated()), id: \.offset) { idx, entry in
                                    if idx > 0 { Divider().background(TP.divider) }
                                    HStack(spacing: 12) {
                                        VStack(spacing: 1) {
                                            Text("FL")
                                                .font(.tpLabel)
                                                .foregroundStyle(TP.textMuted)
                                            Text("\(entry.floor.number)")
                                                .font(.system(size: 13, weight: .heavy).monospacedDigit())
                                                .foregroundStyle(TP.safety)
                                        }
                                        .frame(width: 30)
                                        ItemRow(item: entry.item, currency: project.currency)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            store.deleteItem(entry.item.id, from: entry.floor.id, in: project.id)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                            .tpCard()
                        }

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                chip(label: "ALL", active: filterCategory == nil) {
                    filterCategory = nil
                }
                ForEach(MaterialCategory.allCases) { cat in
                    chip(label: cat.label.uppercased(), active: filterCategory == cat) {
                        filterCategory = filterCategory == cat ? nil : cat
                    }
                }
            }
        }
    }

    private func chip(label: String, active: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .kerning(0.8)
                .foregroundStyle(active ? TP.onSafety : TP.text)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(active ? TP.safety : TP.card)
                .overlay(
                    RoundedRectangle(cornerRadius: TP.radiusSm)
                        .strokeBorder(TP.border, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
        }
        .buttonStyle(.plain)
    }
}
