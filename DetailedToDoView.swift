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
    @State private var cancellationAlert: Bool = false
    @State private var presentErrorAlert: Bool = false
    @State private var currentError: ToDoError? = nil
    weak var delegate: ToDoViewModel?

    init(todo: ToDo, delegate: ToDoViewModel? = nil) {
        self.todo = todo
        self.delegate = delegate
        self._editedTitle = State(wrappedValue: todo.taskName)
        self._title = State(initialValue: todo.taskName)
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
            HStack {
                Text("Profile:").font(.title3).padding()
                Text(todo.profile.description.capitalized).font(.title3)
                Spacer()
            }
            Spacer()
        }
        .alert(currentError?.rawValue ?? "Add missing properties", isPresented: $presentErrorAlert, actions: {})
        .alert("Confirm cancellation", isPresented: $cancellationAlert, actions: {
            Button("Cancel", role: .cancel, action: {
                cancellationAlert = false
            })
            Button("Continue", role: .destructive, action: {
                self.resetValues()
                self.isEditing.toggle()
            })
        }, message: {
            Text("All data will be lost")
        })
        .navigationBarTitle(isEditing ? "Edit Task" : "Task Details")
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: {
                if isEditing {
                    Button("Cancel") {
                        if self.isEdited() {
                            self.cancellationAlert.toggle()
                        } else {
                            self.isEditing.toggle()
                        }
                    }
                }
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(isEditing ? "Save" : "Edit") {
                    if self.isValidTodo() {
                        self.isEditing.toggle()
                    } else {
                        self.presentErrorAlert.toggle()
                    }
                }
            })
        }
    }

    private func isEdited() -> Bool {
        if self.editedTitle != self.title {
            return true
        }
        return false
    }

    private func isValidTodo() -> Bool {
        if self.editedTitle.isEmpty {
            currentError = .missingTitle
            return false
        }
        currentError = nil
        return true
    }

    private func resetValues() {
        self.editedTitle = self.title
    }
}
