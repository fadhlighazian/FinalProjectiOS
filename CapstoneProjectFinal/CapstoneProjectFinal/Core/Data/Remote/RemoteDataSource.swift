//
//  RemoteDataSource.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
  func getMovies() -> AnyPublisher<[Movie], Error>
}

final class RemoteDataSource: NSObject {
  let apiKey = "02b26526598c878b02d249743e3f3373"
  let language = "en-US"
  let page = "1"
  
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getMovies() -> AnyPublisher<[Movie], Error> {
    guard var components = URLComponents(string: Endpoints.Gets.movies.url) else { return URLError.invalidResponse as! AnyPublisher<[Movie], Error> }
    components.queryItems = [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "page", value: page)
    ]
    let request = URLRequest(url: components.url!)
    
    return Future<[Movie], Error> { completion in
      if let url = URL(string: "\(request)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: MoviesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.movies))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
