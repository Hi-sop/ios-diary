//
//  DiaryCoreDataCRUD.swift
//  Diary
//
//  Created by Hisop on 2024/01/14.
//

import CoreData
import UIKit

extension HomeViewController {
    func saveCoreData(_ data: Diary) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Diary", in: delegate.persistentContainer.viewContext) else {
            return
        }
        
        let diaryMO = DiaryMO(entity: entity, insertInto: delegate.persistentContainer.viewContext)

        diaryMO.setValue(data.title, forKey: "title")
        diaryMO.setValue(data.body, forKey: "body")
        diaryMO.setValue(data.createdAt, forKey: "createdAt")
        
        guard delegate.persistentContainer.viewContext.hasChanges else {
            return
        }
        
        do {
            try delegate.persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCoreData() -> [Diary] {
        var diary: [Diary] = []
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        do {
            let diaryMOs = try delegate.persistentContainer.viewContext.fetch(DiaryMO.fetchRequest())
            
            for diaryMO in diaryMOs {
                guard let title = diaryMO.title,
                      let body = diaryMO.body else {
                    return []
                }
                
                let newDiary = Diary(title: title, body: body, createdAt: Int(diaryMO.createAt))
                diary.append(newDiary)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return diary
    }
    
//    func updateCoreData(_ data: Diary) {
//        let request = DiaryMO.fetchRequest()
//        request.predicate = NSPredicate(format: "index == %@", data as CVarArg)
//        
//        do {
//            let userMOs = try appDelegate.persistentContainer.viewContext.fetch(request)
//            
//            guard let userMO = userMOs.first else {
//                return
//            }
//            
//            userMO.name = data.name
//            try appDelegate.persistentContainer.viewContext.save()
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func deleteCoreData(_ data: User) {
//        let request = UserMO.fetchRequest()
//        request.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
//        
//        do {
//            let userMOs = try appDelegate.persistentContainer.viewContext.fetch(request)
//            
//            guard let userMO = userMOs.first else {
//                return
//            }
//            
//            appDelegate.persistentContainer.viewContext.delete(userMO)
//            
//            try appDelegate.persistentContainer.viewContext.save()
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}
