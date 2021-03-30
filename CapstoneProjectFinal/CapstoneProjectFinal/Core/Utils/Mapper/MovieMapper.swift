//
//  MovieMapper.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation

final class MovieMapper {

  static func mapMovieResponsesToDomains(
    input movieResponses: [Movie]
  ) -> [MovieModel] {

    return movieResponses.map { result in
      return MovieModel(
        id: result.id ?? 0,
        title: result.title ?? "Unknow",
        image: result.image ?? "Unknow"
      )
    }
  }
  
  static func mapMovieResponsesToEntities(
    input movieResponses: [Movie]
  ) -> [MovieEntity] {
    return movieResponses.map { result in
      let newMovie = MovieEntity()
      newMovie.id = result.id ?? 0
      newMovie.title = result.title ?? "Unknow"
      newMovie.image = result.image ?? "Unknow"
      return newMovie
    }
  }
   
  static func mapMovieEntitiesToDomains(
    input movieEntities: [MovieEntity]
  ) -> [MovieModel] {
    return movieEntities.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        image: result.image
      )
    }
  }
  
}
