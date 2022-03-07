//
//  ContentView.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import SwiftUI

struct ToDoView: View {
    @StateObject var viewModel: ToDoViewModel = ToDoViewModel()
    @State var showAddButton: Bool = true
    @State var showingSheet: Bool = false
    var body: some View {
        ZStack {
            NavigationView() {
                List(viewModel.todos, id: \.id) { todo in
                    NavigationLink(
                        destination: DetailedToDoView(todo: todo, delegate: self.viewModel)
                    ) {
                        Text(todo.taskName)
                    }
                    .contextMenu {
                        Button {

                        } label: {
                            Label("Edit task", systemImage: "pencil")
                        }
                        Button {

                        } label: {
                            Label("Delete task", systemImage: "trash")
                        }
                    }
                }
                .onAppear(perform: {
                    withAnimation(Animation.easeOut(duration: 0.3)) {
                        self.showAddButton = true
                    }
                })
                .onDisappear(perform: {
                    withAnimation(Animation.easeOut(duration: 0.3)) {
                        self.showAddButton = false
                    }
                })
                .navigationBarTitle(Text("To-Do"))
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingSheet.toggle()
                    },
                           label: {
                        Text("+")
                            .font(.largeTitle)
                            .frame(width: 77, height: 70)
                            .foregroundColor(.white)
                            .padding(.bottom, 7)
                    })
                        .background(.blue.opacity(0.7))
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(
                            color: .black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3
                        )
                }
            }.opacity(self.showAddButton ? 1 : 0)
        }
        .fullScreenCover(isPresented: $showingSheet, onDismiss: nil, content: {
            CreateToDoView(delegate: self.viewModel)
        })
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}

enum ViewingMode: Equatable {
    case editing(todo: ToDo)
    case adding
    case viewing
}
