//
//  API.swift
//  RecipeAPp
//
//  Created by Khavishini on 14/02/2024.
//

import Foundation


struct API {
    
    static let shared = API()
    
    let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    
    func fetchRequest<T: Codable>(url: String,generalType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let urlString = URL(string: baseUrl + url)!
        print("URL: \(urlString)")
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request){ (data, response, error) in

            guard let data = data else {
                completion(.failure(error!))
                return
            }

            let result = Result {
                try JSONDecoder().decode(T.self, from: data)
            }
            completion(result)
        }.resume()
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
