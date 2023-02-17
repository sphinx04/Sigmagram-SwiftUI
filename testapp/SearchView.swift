//
//  SearchView.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 27.01.23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var query: String = ""
    private let threeColumnGrid = [
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
    var body: some View {
        
        ScrollView {
            NavigationView() {
                ZStack {
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(.secondary)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $query)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            .navigationTitle("search")
            .frame(maxHeight: 36)
            
            
            
            LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 0) {
                ForEach(0..<100) { _ in
                    AsyncImage(url: URL(string: "https://picsum.photos/300")!) { postPic in
                        postPic
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1/1, contentMode: .fit)
                    } placeholder: {
                        ZStack {
                            Image("Placeholder")
                                .resizable()
                                .aspectRatio(1/1, contentMode: .fit)
                            ProgressView()
                        }
                    }
                }
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
