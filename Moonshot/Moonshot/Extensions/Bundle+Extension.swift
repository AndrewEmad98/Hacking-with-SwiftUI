//
//  Bundle+Extension.swift
//  Moonshot
//
//  Created by Andrew Emad on 10/11/2024.
//

import Foundation


extension Bundle {
    func fetch<T>(file: String) -> T where T:Codable {
        guard let resourceURL = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("can't find \(file) in the bundle")
        }
        do {
            let fileContent = try Data(contentsOf: resourceURL)
            let jsonDecoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            jsonDecoder.dateDecodingStrategy = .formatted(formatter)
            let response = try jsonDecoder.decode(T.self, from: fileContent)
            return response
        }catch{
            fatalError("can't get \(file) data")
        }
    }
}
