//
//  ContentView.swift
//  MyBooks
//
//  Created by Ravikanth  on 2/19/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @State private var createNewBook = false
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Book.title) private var books :[Book]
    
    var body: some View {
        
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
                }else{
                    List {
                        ForEach(books){ book in
                            NavigationLink{ EditBookView(book: book)} label: {
                                HStack(spacing: 10){
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        
                                        if let rating = book.rating{
                                            HStack {
                                                ForEach(0..<rating,id:\.self){_ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundColor(.yellow)
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                modelContext.delete(book)
                            }
                        }
                
                    }
                    .listStyle(.plain)
                   
                }
            }
            .navigationTitle("My Book")
            .toolbar{
                Button {
                    createNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook){
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
