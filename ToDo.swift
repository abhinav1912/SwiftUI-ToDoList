//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import Foundation

struct ToDo: Identifiable, Equatable {
    var id = UUID()
    let taskName: String
    let description: String?
    let profile: Profile
    let deadline: Date?
}
