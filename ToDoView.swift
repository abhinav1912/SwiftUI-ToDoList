//
//  ContentView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import SwiftUI

struct ToDoView: View {
    var viewModel: ToDoViewModel = ToDoViewModel()
    var body: some View {
        NavigationView() {
            List(viewModel.todos) { todo in
                NavigationLink(destination: Text(todo.taskName).font(.largeTitle)) {
                    HStack {
                        Text(todo.taskName)
                    }
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
