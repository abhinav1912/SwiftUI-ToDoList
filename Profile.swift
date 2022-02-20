//
//  Profile.swift
//  ToDoList
//
//  Created by Abhinav Mathur on 18/02/22.
//

import Foundation

enum Profile: String, CaseIterable, Identifiable {
    case work
    case personal
    case leisure
    case other
    var description: String {
        return self.rawValue
    }
    var id: Profile { self }
}
