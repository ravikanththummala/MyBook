//
//  NewBookView.swift
//  MyBooks
//
//  Created by Ravikanth  on 2/19/24.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""

    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Book Title", text: $title)
                TextField("Author", text: $author)
                
                Button(action: {
                    let newBook = Book(title:title,author:author)
                    modelContext.insert(newBook)
                    
                    dismiss()
                }, label: {
                    Text("create")
                })
                .frame(maxWidth: .infinity,alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("New Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
