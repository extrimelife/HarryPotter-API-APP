//
//  NetworkManager.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping([Character]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let harryPotter = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(harryPotter)
                    print(harryPotter)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }.resume()
    }
}

enum Link: String {
    case harryPotterApi = "https://hp-api.onrender.com/api/characters"
}
