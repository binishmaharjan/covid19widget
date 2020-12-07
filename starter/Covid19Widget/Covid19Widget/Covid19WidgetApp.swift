//
//  Covid19WidgetApp.swift
//  Covid19Widget
//
//  Created by Maharjan Binish on 2020/11/24.
//

import SwiftUI

@main
struct Covid19WidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
