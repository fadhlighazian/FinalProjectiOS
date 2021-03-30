//
//  MovieEntity.swift
//  CapstoneProjectFinal
//
//  Created by Ghazian Fadhli Fakhrusy on 30/03/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
  @objc dynamic var id: Int64 = 0
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
