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
    @State private var title: String = ""
    @State private var editedTitle: String
    @State private var description: String = ""
    @State private var editedDescription: String
    @State private var editedProfile: Profile = .other
    @State private var deadline: Date = .now
    @State private var profile = Profile.work
    @State private var addDeadline: Bool = false
    @State private var presentingSheet: Bool = false
    @State private var isEditing: Bool = false
    @State private var cancellationAlert: Bool = false
    @State private var presentErrorAlert: Bool = false
    @State private var currentError: ToDoError? = nil
    weak var delegate: ToDoViewModel?

    init(todo: ToDo, delegate: ToDoViewModel? = nil) {
        self._todo = State(initialValue: todo)
        self.delegate = delegate
        self._editedTitle = State(wrappedValue: todo.taskName)
        self._title = State(initialValue: todo.taskName)
        self._profile = State(initialValue: todo.profile)
        self._editedProfile = State(initialValue: todo.profile)
        self._editedDescription = State(wrappedValue: todo.description ?? "")
        if let deadline = todo.deadline {
            self._deadline = State(initialValue: deadline)
        }
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
            if isEditing {
                TextField("Enter description (optional)", text: $editedDescription)
                    .padding()
                    .font(.title2)
            } else {
                if !self.editedDescription.isEmpty {
                    Text(self.editedDescription)
                        .font(.title2)
                        .padding()
                }
            }
            if isEditing {
                HStack {
                    Text("Select profile:").font(.title2).padding()
                    Menu {
                        Picker("", selection: $editedProfile) {
                            ForEach(Profile.allCases) { cs in
                                Text(cs.description.capitalized)
                            }
                        }
                    } label: {
                        Text(editedProfile.description.capitalized)
                            .font(.title2)
                    }.id(editedProfile)
                    Spacer()
                }
            } else {
                Text("Profile: \(todo.profile.description.capitalized)").font(.title3).padding()
            }
            if isEditing {
                Toggle(isOn: $addDeadline){
                    Text("\(self.todo.deadline != nil ? "Edit" : "Add") Deadline").font(.title2)
                }.padding()
            }
            if let deadline = todo.deadline {
                let dateFormatter = self.getDateFormatter()
                let date = dateFormatter.string(from: deadline)
                Text("Deadline: \(date)")
                    .font(.title3)
                    .padding()
            }
            if addDeadline && isEditing {
                DatePicker(selection: $deadline, in: Date()..., displayedComponents: .date) {
                    Text("Select a date")
                }
                .datePickerStyle(.graphical)
                .padding()
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
                self.addDeadline = false
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
                            self.addDeadline = false
                        }
                    }
                }
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        if self.isValidTodo() && isEdited() {
                            self.saveTodo()
                            self.isEditing.toggle()
                            self.addDeadline = false
                        } else {
                            if currentError != nil {
                                self.presentErrorAlert.toggle()
                            }
                        }
                    } else {
                        self.isEditing.toggle()
                    }
                }
            })
        }
    }

    private func isEdited() -> Bool {
        let oldAttributes = [self.todo.taskName, self.todo.description, self.todo.profile.description]
        let newAttributes = [self.editedTitle, self.editedDescription, self.editedProfile.description]
        return (oldAttributes != newAttributes || self.todo.deadline != self.deadline)
    }

    private func isValidTodo() -> Bool {
        if self.editedTitle.isEmpty {
            currentError = .missingTitle
            return false
        }
        currentError = nil
        return true
    }

    private func saveTodo() {
        var newTodo = ToDo(taskName: self.editedTitle, description: self.editedDescription, profile: self.editedProfile, deadline: addDeadline ? self.deadline : nil)
        newTodo.id = self.todo.id
        self.delegate?.updateTodo(todo, withTodo: newTodo)
        self.todo = newTodo
        self.resetValues()
    }

    private func resetValues() {
        self.editedTitle = todo.taskName
        if let deadline = todo.deadline {
            self.deadline = deadline
            addDeadline = true
        } else {
            addDeadline = false
            deadline = .now
        }
        self.editedProfile = todo.profile
        self.editedDescription = todo.description ?? ""

    }

    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter
    }
}
