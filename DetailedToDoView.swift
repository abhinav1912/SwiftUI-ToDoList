//
//  DetailedToDoView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 27/02/22.
//

import Foundation
import SwiftUI

struct DetailedToDoView: View {
    @State var todo: ToDo
    @State private var presentingSheet: Bool = false
    weak var delegate: ToDoViewModel?

    var body: some View {
        VStack {
            if let description = todo.description, !description.isEmpty {
                Text(description)
                    .font(.title2)
            }
            HStack {
                Text("Profile:").font(.title3).padding()
                Text(todo.profile.description.capitalized).font(.title3)
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle(todo.taskName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button("Edit") {
     
                }
            })
        }
    }
}
