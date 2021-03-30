//
//  MoviesResponse.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation

struct MoviesResponse: Decodable, Hashable {
  let movies: [Movie]
}

struct Movie: Decodable, Hashable {
  let id: Int64?
  let title: String?
  let image: String?
  
  private enum CodingKeys: String, CodingKey {
    case id, title
    case image = "poster_path"
  }
}
