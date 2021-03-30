//
//  HomeView.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        if presenter.loadingState {
          VStack {
            ActivityIndicator()
            Text("Loading...")
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            // Row
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(self.presenter.movies, id: \.id) { items in
                  VStack {
                    AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/original\(items.image)"))
                      .indicator(SDWebImageActivityIndicator.whiteLarge)
                      .resizable()
                      .frame(width: 150, height: 225)
                    Text("Breaking Bad")
                      .font(.title2)
                      .fontWeight(.bold)
                      .foregroundColor(Color.white)
                      .padding(.top, 8)
                  }
                }
              }
            }
          }
        }
      }.padding(.horizontal)
      .navigationBarTitle("The Movie")
    }.onAppear {
      if self.presenter.movies.count == 0 {
        self.presenter.getMovies()
      }
    }
  }
}
