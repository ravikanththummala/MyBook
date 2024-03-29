//
//  Book.swift
//  MyBooks
//
//  Created by Ravikanth  on 2/19/24.
//

import Foundation
import SwiftData
import SwiftUI


@Model
class Book {
    
    var title:String
    var author: String
    var dateAdded:Date
    var dateStarted:Date
    var dateCompleted:Date
    var summary:String
    var rating:Int?
    var status:Status
    
    init(title: String, 
         author: String,
         dateAdded: Date = Date.now,
         dateStarted: Date = Date.distantPast,
         dateCompleted: Date = Date.distantPast,
         summary: String = "",
         rating: Int? = nil,
         status: Status = .onSelf) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    var icon:Image {
        switch status {
        case .onSelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    
    case onSelf,inProgress, completed
    
    var id: Self{
        self
    }
    
    var desc:String{
        switch self {
        case .onSelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
