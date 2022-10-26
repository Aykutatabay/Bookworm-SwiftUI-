//
//  ListView.swift
//  CoreDataProject2
//
//  Created by Aykut ATABAY on 26.10.2022.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)]) var book: FetchedResults<Book>
    @State var showingAddScreen = false
    var body: some View {
        NavigationView {
            List {
                ForEach(book) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .font(.headline)
                                Text(book.author ?? "Unknown")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem (placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen, content: {
                ContentView()
            })
            
                
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = book[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
