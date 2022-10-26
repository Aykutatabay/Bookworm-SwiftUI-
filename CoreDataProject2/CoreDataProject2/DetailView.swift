//
//  DetailView.swift
//  CoreDataProject2
//
//  Created by Aykut ATABAY on 26.10.2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var showingAlert = false
    let book: Book
    var body: some View {
        ScrollView {
            ZStack (alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre ?? "Fantasy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "Unknown")
                .padding()
            
            RatingView(rating: .constant(Int16(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
            
        }
        
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
    }
}

