//
//  Learning_AppApp.swift
//  Shared
//
//  Created by Ekkehard Koch on 2022.04.06.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
