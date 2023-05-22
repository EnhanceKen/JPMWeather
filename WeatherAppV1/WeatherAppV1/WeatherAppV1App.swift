//
//  WeatherAppV1App.swift
//  WeatherAppV1
//
//  Created by Consultant on 5/19/23.
//

import SwiftUI

@main
struct WeatherAppV1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
