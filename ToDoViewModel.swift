//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import Foundation

class ToDoViewModel: ObservableObject {
    let taskName: String
    let description: String?
    let profile: Profile
    let deadline: Date?

    init(taskName: String, description: String? = nil, profile: Profile, deadline: Date? = nil) {
        self.taskName = taskName
        self.description = description
        self.profile = profile
        self.deadline = deadline
    }
}
