//
//  ContentView.swift
//  CoreDataProject2
//
//  Created by Aykut ATABAY on 26.10.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var review = ""
    @State private var author = ""
    @State private var genre = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", ]
    @State private var rating: Int16 = 3
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection:$genre ) {
                        ForEach (genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section {
                    Button("Add") {
                        if !isAppropriate() {
                            let book = Book(context: moc)
                            book.id = UUID()
                            book.rating = rating
                            book.author = author
                            book.genre = genre
                            book.review = review
                            book.title = title
                            
                            try? moc.save()
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            
                        }
                    }
                }                
            }
            .navigationTitle("Add Book")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button(alertMessage, role: .cancel) {
                }
            }
        }
    }    
    func isAppropriate() -> Bool {
        if title.isEmpty || review.isEmpty || author.isEmpty {
            showingAlert = true
            alertTitle = "Cannot be empty!"
            alertMessage = "You must fill all the fields"
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
