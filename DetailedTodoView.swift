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
                        Picker("Select a paint color", selection: $selection) {
                            ForEach(Profile.allCases) { cs in
                                Text(cs.description.capitalized)
                            }.font(.title)
                        }
                        .pickerStyle(.menu)
                        .font(.title)
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
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Add") {
                        if self.isValidTodo(){
                            delegate?.addTodo(self.getToDo())
                            dismiss()
                        }
                    }
                })
            }
        }
    }

    private func isValidTodo() -> Bool {
        if self.title.isEmpty {
            return false
        }
        return true
    }

    private func getToDo() -> ToDo {
        return ToDo(taskName: self.title, description: nil, profile: self.profile, deadline: nil)
    }
}

enum ToDoError: Error {
    case missingTitle
}
