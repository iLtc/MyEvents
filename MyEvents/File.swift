//
//  File.swift
//  MyEvents
//
//  Created by Alan Luo on 1/20/25.
//

import Foundation

struct File {
  static func save(_ data: Data) {
    let url = URL.documentsDirectory.appendingPathComponent("events.json")
    print(url)

    do {
      try data.write(to: url, options: [.atomic, .completeFileProtection])
    } catch {
      print(error.localizedDescription)
    }
  }
}
