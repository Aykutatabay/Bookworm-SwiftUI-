//
//  DataController.swift
//  CoreDataProject2
//
//  Created by Aykut ATABAY on 26.10.2022.
//
import CoreData
import Foundation
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
