//
//  MainView.swift
//  testapp
//
//  Created by Mnatsakan Zurnadzhian on 27.01.23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            FeedView().tabItem {
                Image(systemName: "house")
            }
            
            SearchView().tabItem {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
