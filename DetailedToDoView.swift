//
//  DetailedToDoView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 27/02/22.
//

import Foundation
import SwiftUI

struct DetailedToDoView: View {
    var todo: ToDo
    @State private var title: String = ""
    @State private var editedTitle: String
    @State private var description: String = ""
    @State private var profile: Profile = .other
    @State private var deadline: Date = .now
    @State private var selection = Profile.work
    @State private var presentingSheet: Bool = false
    @State private var isEditing: Bool = false
    weak var delegate: ToDoViewModel?

    internal init(todo: ToDo, delegate: ToDoViewModel? = nil) {
        self.todo = todo
        self.delegate = delegate
        self._editedTitle = State(wrappedValue: todo.taskName)
        self.title = todo.taskName
        self.profile = todo.profile
        if let description = todo.description {
            self.description = description.isEmpty ? "Enter description (optional)" : description
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter title", text: $editedTitle)
                .padding()
                .font(.title)
                .disabled(!isEditing)
            if let description = todo.description, !description.isEmpty {
                Text(description)
                    .font(.title2)
            }
            Divider()
            HStack {
                Text("Profile:").font(.title3).padding()
                Text(todo.profile.description.capitalized).font(.title3)
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle(isEditing ? "Edit Task" : "Task Details")
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: {
                if isEditing {
                    Button("Cancel") {
                        self.isEditing.toggle()
                    }
                }
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button("Edit") {
                    self.isEditing.toggle()
                }
            })
        }
    }
}
