//
//  DetailedTodoView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 20/02/22.
//

import Foundation
import SwiftUI

struct CreateToDoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var profile: Profile = .other
    @State private var selection = Profile.work
    @State private var presentAlert: Bool = false
    @State private var cancellationAlert: Bool = false
    @State private var currentError: ToDoError? = nil
    @State private var hasDeadline: Bool = false
    @State private var selectedDate: Date = Date()

    @State var viewingMode: ViewingMode = .adding
    weak var delegate: ToDoViewModel?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Title", text: $title)
                    .font(.title)
                    .padding(.top)
                    .padding()
                TextField("Enter description (optional)", text: $description)
                    .font(.title2)
                    .padding()
                HStack {
                    Text("Select profile:").font(.title2).padding()
                    Menu {
                        Picker("Select a paint color", selection: $selection) {
                            ForEach(Profile.allCases) { cs in
                                Text(cs.description.capitalized)
                            }
                        }
                    } label: {
                        Text(selection.description.capitalized)
                            .font(.title2)
                    }.id(selection)
                    Spacer()
                }
                Toggle(isOn: $hasDeadline) {
                    Text("Add Deadline")
                        .font(.title2)
                }.padding()
                if hasDeadline {
                    DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                        Text("Select a date")
                    }
                    .datePickerStyle(.graphical)
                    .padding()
                }
                Spacer()
            }
            .alert(currentError?.rawValue ?? "Add missing properties", isPresented: $presentAlert, actions: {})
            .alert("Confirm cancellation", isPresented: $cancellationAlert, actions: {
                Button("Cancel", role: .cancel, action: {
                    cancellationAlert = false
                })
                Button("Continue", role: .destructive, action: {
                    dismiss()
                })
            }, message: {
                Text("All data will be lost")
            })
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Cancel") {
                        if self.title.isEmpty {
                            dismiss()
                        } else {
                            self.cancellationAlert = true
                        }
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Add") {
                        if self.isValidTodo(){
                            delegate?.addTodo(self.getToDo())
                            dismiss()
                        } else {
                            self.presentAlert = true
                        }
                    }
                })
            }
        }
    }

    private func isValidTodo() -> Bool {
        if self.title.isEmpty {
            currentError = .missingTitle
            return false
        }
        currentError = nil
        return true
    }

    private func getToDo() -> ToDo {
        return ToDo(
            taskName: self.title,
            description: self.description.isEmpty ? nil : self.description,
            profile: self.profile,
            deadline: hasDeadline ? self.selectedDate : nil)
    }
}

enum ToDoError: String, Error {
    case missingTitle = "Add a title!"
}
