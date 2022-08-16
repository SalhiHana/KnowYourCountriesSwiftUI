//
//  DetailViewModel.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-15.
//

import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class DetailViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var capitalCoordinate: CLLocationCoordinate2D
    
    var country: Country?
    
    init(country: Country) {
        self.country = country
        self.region = MKCoordinateRegion()
        self.capitalCoordinate = CLLocationCoordinate2D()
    }
    
    func setupMapView() {
        guard let country = country else { return }
        
        let countrySearchRequest = MKLocalSearch.Request()
        countrySearchRequest.naturalLanguageQuery = country.name
        
        let capitalSearchRequest = MKLocalSearch.Request()
        capitalSearchRequest.naturalLanguageQuery = country.capital
        
        let capitalSearch = MKLocalSearch(request: capitalSearchRequest)
        let countrySearch = MKLocalSearch(request: countrySearchRequest)
        
        countrySearch.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            capitalSearch.start { secondResponse, secondError in
                guard let responsee = secondResponse else {
                    print("Error: \(secondError?.localizedDescription ?? "Unknown error").")
                    return
                }
                
                let capitalAnnotation = MKPointAnnotation()
                capitalAnnotation.title = country.capital
                capitalAnnotation.coordinate = CLLocationCoordinate2D(latitude: responsee.boundingRegion.center.latitude, longitude: responsee.boundingRegion.center.longitude)
                DispatchQueue.main.async {
                    self.region = response.boundingRegion
                    self.capitalCoordinate = capitalAnnotation.coordinate
                }
            }
        }
    }
}
