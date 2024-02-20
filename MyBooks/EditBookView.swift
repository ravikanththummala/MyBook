//
//  EditBookView.swift
//  MyBooks
//
//  Created by Ravikanth  on 2/19/24.
//

import SwiftUI

struct EditBookView: View {
    let book: Book
    @State private var status = Status.inProgress
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView:Bool = true

    @Environment(\.dismiss) var dismiss



    var body: some View {
        
        HStack {
            Text("Status")
            Picker("Status",selection: $status){
                ForEach(Status.allCases){ status  in
                    Text(status.desc).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent{
                    DatePicker("",selection: $dateAdded,displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                
                if status == .inProgress || status == .completed {
                    LabeledContent{
                        DatePicker("",selection:$dateStarted,in: dateAdded...,displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                
                if status == .completed {
                    LabeledContent{
                        DatePicker("",selection:$dateCompleted,in:dateAdded...,displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status){  oldValue, newValue in
            
                if !firstView {
                    if newValue == .onSelf{
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    }else if newValue == .inProgress && oldValue == .completed{
                        dateCompleted = Date.distantPast
                    }else if newValue == .inProgress && oldValue == .onSelf{
                        dateStarted = Date.now
                    }else if newValue == .completed && oldValue == .onSelf{
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    }else {
                        dateCompleted = Date.now
                    }
                    
                    firstView = false
                }
            
                
            }
        }
        
        Divider()
        
        LabeledContent{
            RatingsView(maxRating: 5, currentRating: $rating,width: 30)
        } label: {
            Text("Rating")
        }
        
        LabeledContent {
            TextField("",text: $title)
        } label: {
            Text("Title").foregroundStyle(.secondary)
        }
        
        LabeledContent {
            TextField("",text: $author)
        } label: {
            Text("Author").foregroundStyle(.secondary)
        }

        
        Divider()
        
        Text("Summary").foregroundStyle(.secondary)
        TextEditor(text: $summary)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill),lineWidth: 2))
            .padding()
            .textFieldStyle(.roundedBorder)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                if changed {
                    Button("Update"){
                        book.status = status
                        book.rating = rating
                        book.author = author
                        book.title = title
                        book.dateAdded = dateAdded
                        book.dateCompleted = dateCompleted
                        book.dateStarted = dateStarted
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .onAppear {
                status = book.status
                rating = book.rating
                title = book.title
                author = book.author
                summary = book.summary
                dateAdded = book.dateAdded
                dateStarted = book.dateStarted
                dateCompleted = book.dateCompleted
            }
        
    }
    
    var changed:Bool {
        status != book.status
        || rating != book.rating
        || title != book.title
        || author != book.author
        || summary != book.summary
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateCompleted != book.dateCompleted
    }
}
//
//#Preview {
//    NavigationStack {
//        EditBookView()
//
//    }
//}
