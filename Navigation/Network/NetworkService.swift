//
//  NetworkService.swift
//  Navigation
//
//  Created by Kr Qqq on 13.10.2023.
//

import Foundation

struct NetworkService {
    static func request(url: URL) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode = \(httpResponse.statusCode)")
                print("allHeaderFields = \(httpResponse.allHeaderFields)")
                if httpResponse.statusCode != 200 {
                    return
                }
            }
            
            guard let data else {
                print("Нет данных!")
                return
            }
        
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON-данные: \(json)")
            } catch {
                print("Ошибка обработки JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people"
    case starships = "https://swapi.dev/api/starships"
    case planets = "https://swapi.dev/api/planets"
    
    var url: URL? {
        URL(string: self.rawValue)
    }
}
