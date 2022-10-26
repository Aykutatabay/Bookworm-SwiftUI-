//
//  CoreDataProject2App.swift
//  CoreDataProject2
//
//  Created by Aykut ATABAY on 26.10.2022.
//

import SwiftUI

@main
struct CoreDataProject2App: App {
    @StateObject private var datacontroller = DataController()
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
