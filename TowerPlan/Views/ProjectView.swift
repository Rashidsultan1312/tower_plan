import SwiftUI

private struct IdentUUID: Identifiable {
    let id: UUID
}

struct ProjectView: View {
    @EnvironmentObject var store: ProjectStore
    @State private var showAddFloor = false
    @State private var addItemFloor: IdentUUID?
    @State private var showProjects = false

    var body: some View {
        ZStack {
            TP.bgGrad.ignoresSafeArea()

            if let project = store.activeProject {
                ScrollView {
                    VStack(spacing: 14) {
                        header(project: project)

                        EstimateCard(project: project)

                        HStack(spacing: 10) {
                            Button { showAddFloor = true } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "plus")
                                    Text("ADD FLOOR").kerning(1.2)
                                }
                            }
                            .tpPrimaryButton()
                        }

                        sectionLabel("TOWER · \(project.completedFloors) FLOORS")

                        if project.floors.isEmpty {
                            emptyFloorsPlaceholder
                        } else {
                            ForEach(project.floors.sorted { $0.number > $1.number }) { floor in
                                FloorBlock(
                                    floor: floor,
                                    currency: project.currency,
                                    onAdd: {
                                        addItemFloor = IdentUUID(id: floor.id)
                                    },
                                    onDelete: {
                                        store.deleteFloor(floor.id, from: project.id)
                                    }
                                )
                            }
                        }

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
        }
        .sheet(isPresented: $showAddFloor) {
            if let pid = store.activeProjectID {
                AddFloorView(projectID: pid)
                    .environmentObject(store)
            }
        }
        .sheet(item: $addItemFloor) { item in
            if let pid = store.activeProjectID {
                AddItemView(projectID: pid, floorID: item.id)
                    .environmentObject(store)
            }
        }
        .sheet(isPresented: $showProjects) {
            ProjectsListView().environmentObject(store)
        }
    }

    private func header(project: Project) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("TOWER PLAN")
                    .font(.tpLabel)
                    .kerning(2)
                    .foregroundStyle(TP.textMuted)
                if !project.location.isEmpty {
                    Text(project.location)
                        .font(.tpCaption)
                        .foregroundStyle(TP.textSecondary)
                }
            }
            Spacer()
            Button { showProjects = true } label: {
                HStack(spacing: 6) {
                    Image(systemName: "rectangle.stack.fill")
                        .font(.system(size: 13))
                    Text("PROJECTS").kerning(1)
                }
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(TP.safety)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(TP.card)
                .overlay(
                    RoundedRectangle(cornerRadius: TP.radiusSm)
                        .strokeBorder(TP.border, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: TP.radiusSm))
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 4)
    }

    private func sectionLabel(_ text: String) -> some View {
        HStack {
            Text(text)
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            Spacer()
            Rectangle()
                .fill(TP.border)
                .frame(height: 1)
        }
        .padding(.top, 4)
    }

    private var emptyFloorsPlaceholder: some View {
        VStack(spacing: 10) {
            Image(systemName: "square.stack.3d.up.slash")
                .font(.system(size: 36, weight: .light))
                .foregroundStyle(TP.textMuted)
            Text("NO FLOORS ADDED")
                .font(.tpLabel)
                .kerning(1.5)
                .foregroundStyle(TP.textMuted)
            Text("Tap ADD FLOOR to start stacking")
                .font(.tpCaption)
                .foregroundStyle(TP.textFaint)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .tpCard()
    }
}
