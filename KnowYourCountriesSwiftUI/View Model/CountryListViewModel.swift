//
//  CountryListViewModel.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-13.
//

import SwiftUI

class CountryListViewModel: ObservableObject {
    
    let urlString = "https://restcountries.com/v2/all"
    @Published var countries: Countries = []
    @Published var error: Error?
    
    func fetchCountries() {
        
        if let url = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.error = error
                    }
                }
                if let safeData = data {
                    let str = String(decoding: safeData, as: UTF8.self)
                    if
                        let utfData = str.data(using: .utf8),
                        let countries = self.parseJSON(utfData) {
                        DispatchQueue.main.async {
                            self.countries = countries
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private  func parseJSON(_ jsonData: Data) -> Countries? {
        do {
            let newJSONDecoder = JSONDecoder()
            let countries = try newJSONDecoder.decode(Countries.self, from: jsonData)
            return countries
        } catch {
            DispatchQueue.main.async {
                self.error = error
            }
            return nil
        }
    }
}
