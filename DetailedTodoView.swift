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

    var body: some View {
        NavigationView {
            Button("Dismiss"){
                dismiss()
            }
            .font(.largeTitle)
            .navigationTitle(Text("New Task"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Add") {

                    }
                })
            }
        }
    }
}
