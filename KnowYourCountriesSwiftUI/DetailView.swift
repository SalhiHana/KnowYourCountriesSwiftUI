//
//  DetailView.swift
//  KnowYourCountriesSwiftUI
//
//  Created by Hana Salhi on 2022-08-15.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct DetailView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 30) {
                if
                    let stringURL = viewModel.country?.flags.png,
                    let imageURL = URL(string: stringURL) {
                    AnimatedImage(url: imageURL)
                        .resizable()
                        .frame(width: geometry.size.width * 0.95, height: 200)
                        .border(Color(uiColor: UIColor(named: "primaryColor") ?? .black), width: 1)

                } else {
                    Text("NO IMAGE")
                }
                
                ScrollView {
                    VStack(alignment: .center) {
                        
                        DoubleInfoGroup(viewModel: viewModel, width: geometry.size.width * 0.475)
                        
                        SingleInfoView(
                            title: "Timezones",
                            value: viewModel.country?.timezones.joined(separator: ", "),
                            width: geometry.size.width * 0.475
                            
                        )
                            
                        Divider()
                            .frame(height: 1)
                            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
                        .padding()
                        
                        SingleInfoView(
                            title: "Calling Codes",
                            value: viewModel.country?.callingCodes.joined(separator: ", "),
                            width: geometry.size.width * 0.475
                            
                        )
                            
                        Divider()
                            .frame(height: 1)
                            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
                        .padding()
                        
                        SingleInfoView(
                            title: "Currencies",
                            value: viewModel.country?.currencies?.compactMap({ $0.name }).joined(separator: ", "),
                            width: geometry.size.width * 0.475
                        )
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
                        .padding()
                        
                        SingleInfoView(
                            title: "Languages",
                            value: viewModel.country?.languages.compactMap({ $0.name }).joined(separator: ", "),
                            width: geometry.size.width * 0.475
                        )
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
                        .padding()
                        Map(coordinateRegion: $viewModel.region, annotationItems: [viewModel.capitalCoordinate]) { coordinate in
                                MapMarker(coordinate: coordinate)
                            }
                            .frame(height: 400, alignment: .center)
 
                        
                    }
                    .padding(.top, 5)
                }
   
            }
            .onAppear {
                viewModel.setupMapView()
            }
        }
        
    }
    
}

/*

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(country: Country(
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
            gini: nil)))
    }
}
 
*/
struct InfoView: View {
    
    var title: String
    var value: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title.uppercased())
                .foregroundColor(Color(uiColor: UIColor(named: "titleColor") ?? .red))
                .font(.system(size: 13, weight: .bold))
            Text(value ?? "Value is nil")
                .foregroundColor(Color(uiColor: UIColor(named: "valueColor") ?? .red))
                .font(.system(size: 16, weight: .bold))
        }
    }
}

struct DoubleInfoView: View {
    var title1: String
    var title2: String
    var value1: String?
    var value2: String?
    
    var width: CGFloat //geometry.size.width * 0.475
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            InfoView(title: title1, value: value1)
                .padding()
                .frame(width: width, height: 40 , alignment: .leading)
            Divider()
                .frame(width: 1)
                .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
            //.padding()
            InfoView(title: title2, value: value2)
                .padding()
                .frame(width: width, height: 40, alignment: .leading)
        }
    }
}

struct SingleInfoView: View {
    var title: String
    var value: String?
    var width: CGFloat
    
    var body: some View {
        HStack {
            InfoView(title: title, value: value)
                .padding()
                .frame(width: width, height: 40 , alignment: .leading)
            Spacer()
        }
    }
}


struct DoubleInfoGroup: View {
    var viewModel: DetailViewModel
    var width: CGFloat
    var body: some View {
        DoubleInfoView(
            title1: "Name",
            title2: "Capital",
            value1: viewModel.country?.name,
            value2: viewModel.country?.capital,
            width: width
        )
        
        Divider()
            .frame(height: 1)
            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
            .padding()


        DoubleInfoView(
        title1: "Region",
        title2: "Demonym",
        value1: viewModel.country?.region.rawValue,
        value2: viewModel.country?.demonym,
        width: width
    )

        Divider()
        .frame(height: 1)
        .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
        .padding()
                    
        DoubleInfoView(
            title1: "Area",
            title2: "Population",
            value1: viewModel.country?.area?.formatted(),
            value2: viewModel.country?.population.formatted(),
            width: width
        )
        
        Divider()
            .frame(height: 1)
            .background(Color(uiColor: UIColor(named: "primaryColor") ?? .red))
            .padding()
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
