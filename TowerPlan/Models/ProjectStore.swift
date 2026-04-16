import Foundation
import Combine

@MainActor
final class ProjectStore: ObservableObject {
    static let shared = ProjectStore()

    @Published var projects: [Project] = []
    @Published var activeProjectID: UUID?

    private let projectsKey = "tp_projects_v1"
    private let activeKey = "tp_active_project_v1"

    init() {
        load()
    }

    var activeProject: Project? {
        guard let id = activeProjectID else { return projects.first }
        return projects.first { $0.id == id }
    }

    var totalEstimate: Double {
        activeProject?.totalEstimate ?? 0
    }

    func addProject(_ p: Project) {
        projects.append(p)
        if activeProjectID == nil { activeProjectID = p.id }
        save()
    }

    func deleteProject(_ id: UUID) {
        projects.removeAll { $0.id == id }
        if activeProjectID == id { activeProjectID = projects.first?.id }
        save()
    }

    func selectProject(_ id: UUID) {
        activeProjectID = id
        save()
    }

    func renameProject(_ id: UUID, name: String) {
        guard let idx = projects.firstIndex(where: { $0.id == id }) else { return }
        projects[idx].name = name
        save()
    }

    func addFloor(_ floor: Floor, to projectID: UUID) {
        guard let idx = projects.firstIndex(where: { $0.id == projectID }) else { return }
        projects[idx].floors.append(floor)
        projects[idx].floors.sort { $0.number > $1.number }
        save()
    }

    func deleteFloor(_ floorID: UUID, from projectID: UUID) {
        guard let idx = projects.firstIndex(where: { $0.id == projectID }) else { return }
        projects[idx].floors.removeAll { $0.id == floorID }
        save()
    }

    func addItem(_ item: BuildItem, to floorID: UUID, in projectID: UUID) {
        guard let pIdx = projects.firstIndex(where: { $0.id == projectID }),
              let fIdx = projects[pIdx].floors.firstIndex(where: { $0.id == floorID }) else { return }
        projects[pIdx].floors[fIdx].items.insert(item, at: 0)
        save()
    }

    func deleteItem(_ itemID: UUID, from floorID: UUID, in projectID: UUID) {
        guard let pIdx = projects.firstIndex(where: { $0.id == projectID }),
              let fIdx = projects[pIdx].floors.firstIndex(where: { $0.id == floorID }) else { return }
        projects[pIdx].floors[fIdx].items.removeAll { $0.id == itemID }
        save()
    }

    func categoryBreakdown() -> [(MaterialCategory, Double)] {
        guard let p = activeProject else { return [] }
        var totals: [MaterialCategory: Double] = [:]
        for floor in p.floors {
            for item in floor.items {
                totals[item.category, default: 0] += item.cost
            }
        }
        return totals.sorted { $0.value > $1.value }
    }

    func floorBreakdown() -> [(Floor, Double)] {
        guard let p = activeProject else { return [] }
        return p.floors
            .sorted { $0.number > $1.number }
            .map { ($0, $0.totalCost) }
    }

    func allItems() -> [(floor: Floor, item: BuildItem)] {
        guard let p = activeProject else { return [] }
        return p.floors.flatMap { floor in
            floor.items.map { (floor, $0) }
        }
    }

    func resetAll() {
        projects = []
        activeProjectID = nil
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(projects)
            UserDefaults.standard.set(data, forKey: projectsKey)
            if let id = activeProjectID {
                UserDefaults.standard.set(id.uuidString, forKey: activeKey)
            } else {
                UserDefaults.standard.removeObject(forKey: activeKey)
            }
        } catch {
            print("ProjectStore: сохранение не удалось — \(error)")
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: projectsKey),
           let decoded = try? JSONDecoder().decode([Project].self, from: data) {
            projects = decoded
        }
        if let idStr = UserDefaults.standard.string(forKey: activeKey),
           let id = UUID(uuidString: idStr) {
            activeProjectID = id
        } else {
            activeProjectID = projects.first?.id
        }
    }
}
