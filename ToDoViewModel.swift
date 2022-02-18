//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import Foundation

struct ToDoViewModel: Identifiable {
    let id = UUID()
    let taskName: String
    let description: String?
    let profile: Profile
    let deadline: Date?
}
