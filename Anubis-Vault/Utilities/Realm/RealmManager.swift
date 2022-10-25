//
//  RealmManager.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 23/10/2022.
//

import Foundation
import RealmSwift

enum AnubisBaseErrorCode: String, LocalizedError {
    case invaildObject = "An error has been occurred while processing your request."
    case notExists = "Cannot find your entity."
    var errorDescription: String? {
        return self.rawValue
    }
}

protocol Repository: AnyObject {
    func createEntity<T: Object>(entity: T, handler: @escaping(Result<Object, Error>) -> Void)
    func getEntites<T: Object>(as: T.Type, handler: @escaping(Result<Results<T>, Error>) -> Void)
    func getEntity<T: Object>(as: T.Type, entityPrimaryKey: String, handler: @escaping(Result<T, Error>) -> Void)
    func getEntites<T: Object>(as: T.Type, searchBlock: @escaping(T) -> (Bool), handler: @escaping(Result<[T], Error>) -> Void)
    func getEntites<T: Object>(as: T.Type, ascending: Bool, handler: @escaping(Result<Results<T>, Error>) -> Void)
    func deleteEntity<T: Object>(_ entity: T, handler: @escaping(Bool) -> Void)
    func updateEntity(updateBlock: () -> (), handler: @escaping(Bool) -> Void)
}

final class RealmManager: Repository {

    private let realmThreadSafe = DispatchQueue(label: "...", attributes: .concurrent)
    
    private var realm: Realm! {
        get {
            return realmThreadSafe.sync {
                let baseRealm = try? Realm()
                return baseRealm
            }
        }
    }
    
    func createEntity<T: Object>(entity: T, handler: @escaping(Result<Object, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(entity)
                let entityReference = ThreadSafeReference(to: entity)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let entity = self.realm.resolve(entityReference) else {
                        handler(.failure(AnubisBaseErrorCode.invaildObject))
                        return
                    }
                    handler(.success(entity))
                }
            }
        } catch {
            handler(.failure(error))
        }
    }
    
    func getEntites<T: Object>(as: T.Type, handler: @escaping(Result<Results<T>, Error>) -> Void) {
        let entites = realm.objects(T.self)
        let entitesReference = ThreadSafeReference(to: entites)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let entites = self.realm.resolve(entitesReference) else {
                handler(.failure(AnubisBaseErrorCode.invaildObject))
                return
            }
            handler(.success(entites))
        }
    }
    
    func getEntity<T: Object>(as: T.Type, entityPrimaryKey: String, handler: @escaping(Result<T, Error>) -> Void) {
        do {
            let entity = realm.object(ofType: T.self, forPrimaryKey: entityPrimaryKey)
            guard let entity = entity else {
                throw AnubisBaseErrorCode.notExists
            }
            handler(.success(entity))
        }
        catch {
            handler(.failure(error))
        }
    }
    
    func getEntites<T: Object>(as: T.Type, ascending: Bool = true, handler: @escaping(Result<Results<T>, Error>) -> Void) {
        let entites = realm.objects(T.self).sorted(byKeyPath: "createdAt", ascending: ascending)
        let entitesReference = ThreadSafeReference(to: entites)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let entites = self.realm.resolve(entitesReference) else {
                handler(.failure(AnubisBaseErrorCode.notExists))
                return
            }
            handler(.success(entites))
        }
    }
    
    func getEntites<T: Object>(as: T.Type, searchBlock: @escaping(T) -> (Bool), handler: @escaping(Result<[T], Error>) -> Void) {
        
        do {
            let entites = realm.objects(T.self)
            let entitesReference = ThreadSafeReference(to: entites)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let entites = self.realm.resolve(entitesReference) else {
                    handler(.failure(AnubisBaseErrorCode.notExists))
                    return
                }
                handler(.success(entites.filter(searchBlock)))
            }
        } catch {
            handler(.failure(error))
        }
        
    }
    
    func deleteEntity<T: Object>(_ entity: T, handler: @escaping(Bool) -> Void) {
        do {
            try realm.write({
                realm.delete(entity)
                handler(true)
            })
        } catch {
            handler(false)
        }
    }
    
    func updateEntity(updateBlock: () -> (), handler: @escaping(Bool) -> Void) {
        do {
            try realm.write(updateBlock)
            handler(true)
        } catch {
            handler(false)
        }
    }
}
