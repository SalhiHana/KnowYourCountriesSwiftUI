//
//  KnowYourCountriesSwiftUIApp.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-13.
//

import SwiftUI

@main
struct KnowYourCountriesSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CountryListView(viewModel: CountryListViewModel())
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
