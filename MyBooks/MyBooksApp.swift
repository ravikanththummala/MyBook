//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Ravikanth  on 2/19/24.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {

    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
    
    init(){
        print("Path \(URL.applicationSupportDirectory.path(percentEncoded: false))")
    }
}
