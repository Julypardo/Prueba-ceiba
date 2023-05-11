//
//  Persistence.swift
//  PruebaCeiba
//
//  Created by July Pardo on 10/05/23.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "PruebaCeiba")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("No se pudo cargar el almacenamiento persistente: \(error)")
            }
        }
    }
}
