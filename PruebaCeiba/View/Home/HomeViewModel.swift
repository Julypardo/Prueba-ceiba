//
//  HomeViewModel.swift
//  PruebaCeiba
//
//  Created by July Pardo on 11/05/23.
//

import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    
    @Published var search: String = ""
    
    @Published var responseUsers = [User]()
    @Published var users = [User]()
    
    private let repository = Repository()
    private let persistenceController: PersistenceController
    
    init() {
        persistenceController = PersistenceController.shared
        
        self.responseUsers = getUsersFromCoreData()
        if responseUsers.isEmpty {
            self.fetchUsers()
        } else {
            self.users = self.responseUsers
        }
    }
    
    func fetchUsers() {
        repository.fetchUsers { [weak self] users in
            DispatchQueue.main.async {
                self?.responseUsers = users
                self?.users = users
                self?.saveUsersToCoreData(self?.users ?? [])
            }
        }
    }
    
    private func saveUsersToCoreData(_ users: [User]) {
        let context = persistenceController.container.viewContext
        // Eliminar usuarios existentes en Core Data
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("No se pudo eliminar usuarios existentes en Core Data: \(error)")
        }
        // Crear objetos de usuario y guardar en Core Data
        for user in users {
            let userEntity = UserEntity(context: context)
            userEntity.user_id = Int16(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
            userEntity.email = user.email
            userEntity.phone = user.phone
            // guardar cambios
            do {
                try context.save()
            } catch let error as NSError {
                print("No se pudo guardar usuario en Core Data: \(error)")
            }
        }
    }
    
    func filterUsersByName(_ name: String) {
        if name.isEmpty {
            self.users = self.responseUsers
        } else {
            users = users.filter { user in
                return user.name.lowercased().contains(name.lowercased())
            }
        }
    }
    
    func getUsersFromCoreData() -> [User] {
        var users = [User]()
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let userEntities = try context.fetch(request)
            for userEntity in userEntities {
                let user = User(id: Int(userEntity.user_id), name: userEntity.name ?? "", username: userEntity.username ?? "", email: userEntity.email ?? "", phone: userEntity.phone ?? "")
                users.append(user)
            }
        } catch let error as NSError {
            print("No se pudo obtener usuarios de Core Data: \(error)")
        }
        return users
    }
    
    func fetchPosts(_ userId: Int, completion: @escaping ([Post]) -> Void) {
        repository.fetchPosts(userId) { [weak self] posts in
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    }
}
