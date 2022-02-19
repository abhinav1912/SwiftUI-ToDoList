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
        ZStack {
            NavigationView() {
                List(viewModel.todos, id: \.id) { todo in
                    NavigationLink(destination: Text(todo.taskName).font(.largeTitle)) {
                        HStack {
                            Text(todo.taskName)
                        }
                    }
                }
                .navigationBarTitle(Text("To-Do"))
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}, label: {
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
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
