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
    
    static func requestJSONDecoder(appConfiguration: AppConfiguration, completion: @escaping (Result<Any, Error>) -> Void) {
        
        let url = appConfiguration.url!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(NetworkError.error(error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError.error(String(httpResponse.statusCode))))
                    return
                }
            }
            
            guard let data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
        
            let decoder = JSONDecoder()
            do {
                switch appConfiguration {
                case .todos:
                    let todos = try decoder.decode(Todos.self, from: data)
                    completion(.success(todos))
                case .planets:
                    let planets = try decoder.decode(Planets.self, from: data)
                    completion(.success(planets))
                default:
                    completion(.failure(NetworkError.parseError))
                }
                
            } catch {
                completion(.failure(NetworkError.parseError))
            }
        }
        task.resume()
    }
    
    static func requestJSONSerialization(url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(NetworkError.error(error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError.error(String(httpResponse.statusCode))))
                    return
                }
            }
            
            guard let data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
        
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let title = json["title"] as? String {
                    completion(.success(title))
                } else {
                    completion(.failure(NetworkError.parseError))
                }
            } else {
                completion(.failure(NetworkError.parseError))
            }
        }
        task.resume()
    }
}

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people"
    case starships = "https://swapi.dev/api/starships"
    case planets = "https://swapi.dev/api/planets/1"
    case todos = "https://jsonplaceholder.typicode.com/todos/4"
    
    var url: URL? {
        URL(string: self.rawValue)
    }
}

struct Todos: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

struct Planets: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
