//
//  ContentView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
    var body: some View {
      TabView {
        HomeView(presenter: homePresenter)
          .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
          }
        FavoriteView()
          .tabItem {
            Image(systemName: "star.fill")
            Text("Favorite")
          }
        SearchView()
          .tabItem {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        ProfileView()
          .tabItem {
            Image(systemName: "person.crop.circle.fill")
            Text("Profile")
          }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
