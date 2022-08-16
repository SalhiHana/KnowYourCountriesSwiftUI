//
//  ContentView.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-13.
//

import SwiftUI
import CoreData

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    
    @State private var searchString = ""
    
    
    var body: some View {
        NavigationView {
            List(searchResults, id: \.self) { country in
                NavigationLink(destination: DetailView(viewModel: DetailViewModel(country: country))) {
                    CountryRow(country: country)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Country List")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchCountries()
            }
            .searchable(text: $searchString)
        }
        .accentColor(Color(uiColor: UIColor(named: "primaryColor") ?? .black))
    }
    
    var searchResults: [Country] {
        if searchString.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { $0.name.contains(searchString) }
        }
    }
    
}
struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(
            viewModel: CountryListViewModel()
        ).environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
    }
}


extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
