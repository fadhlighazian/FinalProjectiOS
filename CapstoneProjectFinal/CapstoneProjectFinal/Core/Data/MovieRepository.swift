//
//  MovieRepository.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
  func getMovies() -> AnyPublisher<[MovieModel], Error>
}

final class MovieRepository: NSObject {
  typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
    return MovieRepository(locale: localeRepo, remote: remoteRepo)
  }
}

extension MovieRepository: MovieRepositoryProtocol {
  
  func getMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.locale.getMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getMovies()
            .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
            .flatMap { self.locale.addMovies(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getMovies()
              .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
}
