//
//  DetailedTodoView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 20/02/22.
//

import Foundation
import SwiftUI

struct DetailedTodoView: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var description: String = ""
    @State var profile: Profile = .other
    @State var deadline: Date = .now
    @State var viewingMode: ViewingMode = .adding
    @State private var selection = Profile.work
    @State var presentAlert: Bool = false
    @State var cancellationAlert: Bool = false
    @State private var currentError: ToDoError? = nil
    weak var delegate: ToDoViewModel?

    var body: some View {
        NavigationView {
            VStack {
                if self.viewingMode == .adding {
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
                } else {
                    HStack {
                        Text("Title").font(.title)
                            .padding(.leading)
                            .padding(.top)
                            .padding(.top)
                        Spacer()
                    }

                    HStack {
                        Text("Description").font(.title3)
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                    }
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
        return ToDo(taskName: self.title, description: nil, profile: self.profile, deadline: nil)
    }
}

enum ToDoError: String, Error {
    case missingTitle = "Add a title!"
}
