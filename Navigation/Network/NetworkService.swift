//
//  NetworkService.swift
//  Navigation
//
//  Created by Kr Qqq on 13.10.2023.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let session = URLSession.shared
        
        var urlC: URL
        switch configuration {
        case .c1(let url):
            urlC = url
        case .c2(let url):
            urlC = url
        case .c3(let url):
            urlC = url
        }
        
        let task = session.dataTask(with: urlC) { data, response, error in
            
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

enum AppConfiguration {
    case c1(URL)
    case c2(URL)
    case c3(URL)
}
