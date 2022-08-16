//
//  CountryRow.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-13.
//

import SwiftUI
import SDWebImageSwiftUI

struct CountryRow: View {
    var country: Country
    
    var body: some View {
        HStack(spacing: 30) {
            AnimatedImage(url: URL(string: country.flags.png))
                .resizable()
                .frame(width: 108, height: 72, alignment: .center)

                //.padding()
            Text(country.name)
                    .foregroundColor(.primary)
                    .font(.custom("Times New Roman", size: 19))
                    //.padding()
            Spacer()

        }
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: Country(
            name: "Tunisia",
            topLevelDomain: [],
            alpha2Code: "TN",
            alpha3Code: "TUN",
            callingCodes: [],
            capital: "Tunis",
            altSpellings: [],
            subregion: "",
            region: .africa,
            population: 1200000,
            latlng: nil,
            demonym: "",
            area: nil,
            timezones: [],
            borders: nil,
            nativeName: "",
            numericCode: "",
            flags: Flags(svg: "", png: ""),
            currencies: nil,
            languages: [],
            translations: Translations(br: "", pt: "", nl: "", hr: "", fa: "", de: "", es: "", fr: "", ja: "", it: "", hu: ""), flag: "",
            regionalBlocs: nil,
            cioc: nil,
            independent: true,
            gini: nil))
    }
}
