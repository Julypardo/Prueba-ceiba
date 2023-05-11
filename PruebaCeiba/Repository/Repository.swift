//
//  Repository.swift
//  PruebaCeiba
//
//  Created by July Pardo on 11/05/23.
//

import Foundation

class Repository {
    func fetchUsers(completion: @escaping ([User]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("URL inválida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No se pudo obtener los datos: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([User].self, from: data)
                completion(users)
            } catch {
                print("No se pudo decodificar los datos: \(error.localizedDescription)")
            }
        }.resume()
    }
}
