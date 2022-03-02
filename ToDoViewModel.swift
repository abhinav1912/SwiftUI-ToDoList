//
//  ToDoViewModel.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 19/02/22.
//

import Foundation
import SwiftUI

class ToDoViewModel: ObservableObject {
    @Published private(set) var todos: [ToDo] = [
        ToDo(taskName: "Task 1", description: nil, profile: .work, deadline: nil),
        ToDo(taskName: "Task 2", description: nil, profile: .work, deadline: nil),
        ToDo(taskName: "Task 3", description: nil, profile: .work, deadline: nil)
    ]

    func addTodo(_ todo: ToDo) {
        self.todos.append(todo)
    }

    func updateTodo(_ todo: ToDo, withTodo newTodo: ToDo) {
        if let index = self.todos.firstIndex(of: todo) {
            todos[index] = newTodo
        }
    }
}
