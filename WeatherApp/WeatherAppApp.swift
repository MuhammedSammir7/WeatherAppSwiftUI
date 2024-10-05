//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by ios on 22/08/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {

            HomeView(isNight: false)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
