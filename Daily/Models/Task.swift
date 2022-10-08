//
//  Task.swift
//  Daily
//
//  Created by varunbhalla19 on 06/10/22.
//

import Foundation

struct Task: Identifiable {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
    var id: String = UUID.init().uuidString
}

extension Array where Element == Task {
    func indexForTask(with id: Task.ID) -> Array.Index {
        guard let index = firstIndex(where: {  $0.id == id }) else { fatalError() }
        return index
    }
}

#if DEBUG

extension Task {
    static let testData = [
        Task(title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0), notes: "Don't forget about taxi receipts"),
        Task(title: "Code review", dueDate: Date().addingTimeInterval(14000.0), notes: "Check tech specs in shared folder", isComplete: true),
        Task(title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0), notes: "Optometrist closes at 6:00PM"),
        Task(title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0), notes: "Collaborate with project manager", isComplete: true),
        Task(title: "Interview new project manager candidate", dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio"),
        Task(title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0), notes: "Think different"),
        Task(title: "Review usage analytics", dueDate: Date().addingTimeInterval(83000.0), notes: "Discuss trends with management"),
        Task(title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0), notes: "Ask about space heaters"),
        Task(title: "Add beta testers to TestFlight", dueDate: Date().addingTimeInterval(101000.0),  notes: "v0.9 out on Friday")
    ]
}


#endif
