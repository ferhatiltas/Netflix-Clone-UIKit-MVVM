//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by ferhatiltas on 23.03.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError : Error{
        case failedToSave
        case failedFetchData
        case failedToDeleteData
    }
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model : Title, completion : @escaping (Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context =  appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_name = model.original_name
        item.originial_title = model.original_title
        item.id = Int64(model.id)
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_avarage = model.vote_average
        do {
            try context.save()
            completion(.success(()))
            
        }catch {
            completion(.failure(DatabaseError.failedToSave))
        }
    }
    
    func fetchTitlesFromDataBase(completion: @escaping (Result<[TitleItem],Error>)-> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(DatabaseError.failedFetchData))
        }
    }
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>)-> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
