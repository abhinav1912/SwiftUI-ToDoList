//
//  ContentView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import SwiftUI

struct ToDoView: View {
    var todos: [ToDo] = [
        ToDo(taskName: "Task 1", description: nil, profile: .work, deadline: nil),
        ToDo(taskName: "Task 2", description: nil, profile: .work, deadline: nil),
        ToDo(taskName: "Task 3", description: nil, profile: .work, deadline: nil)
    ]
    var body: some View {
        NavigationView() {
            List(todos) { todo in
                HStack {
                    Text(todo.taskName)
                }
            }
            .navigationBarTitle(Text("To-Do"))
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
