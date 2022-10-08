//
//  NetworkManager.swift
//  HarryPotterApi
//
//  Created by roman Khilchenko on 24.09.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping([Character]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
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
    
    func fetchImage(from url: String?, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        DispatchQueue.global().async {
            guard let imageUrl = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageUrl)
            }
        }
    }
}

enum Link: String {
    case harryPotterApi = "https://fedeperin-harry-potter-api-en.herokuapp.com/characters"
}
