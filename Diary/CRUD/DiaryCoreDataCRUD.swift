//
//  DiaryCoreDataCRUD.swift
//  Diary
//
//  Created by Hisop on 2024/01/14.
//

import CoreData
import UIKit

extension HomeViewController {
    var delegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return AppDelegate()
        }
        
        return delegate
    }
    
    var diaryEntity: NSEntityDescription {
        guard let diaryEntity = NSEntityDescription.entity(forEntityName: "Diary", in: delegate.persistentContainer.viewContext) else {
            return NSEntityDescription()
        }
        return diaryEntity
    }
    
    var listEntity: NSEntityDescription {
        guard let listEntity = NSEntityDescription.entity(forEntityName: "DiaryList", in: delegate.persistentContainer.viewContext) else {
            return NSEntityDescription()
        }
        return listEntity
    }
    
    func coreDataInit() {
        do {
            let count = try delegate.persistentContainer.viewContext.count(for: DiaryListMO.fetchRequest())
            if count == 0 {
                let _ = DiaryListMO(
                    entity: listEntity,
                    insertInto: delegate.persistentContainer.viewContext
                )
                try delegate.persistentContainer.viewContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveCoreData(_ data: Diary) {
        do {
            guard let diaryListMO = try delegate.persistentContainer.viewContext.fetch(DiaryListMO.fetchRequest()).first else {
                return
            }
            let diaryMO = DiaryMO(
                entity: diaryEntity,
                insertInto: delegate.persistentContainer.viewContext
            )
            diaryMO.title = data.title
            diaryMO.body = data.body
            diaryMO.createdAt = Int64(data.createdAt)
            
            diaryListMO.addToDiarys(diaryMO)
            
            try delegate.persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        
//        guard let entity = NSEntityDescription.entity(forEntityName: "Diary", in: delegate.persistentContainer.viewContext) else {
//            return
//        }
//        
//        let diaryMO = DiaryMO(entity: entity, insertInto: delegate.persistentContainer.viewContext)
//
//        diaryMO.setValue(data.title, forKey: "title")
//        diaryMO.setValue(data.body, forKey: "body")
//        diaryMO.setValue(data.createdAt, forKey: "createdAt")
//        
//        guard delegate.persistentContainer.viewContext.hasChanges else {
//            return
//        }
//        
//        do {
//            try delegate.persistentContainer.viewContext.save()
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    func fetchCoreData() -> [Diary] {
        var diarys: [Diary] = []
        
        do {
            let diaryListMO = try delegate.persistentContainer.viewContext.fetch(DiaryListMO.fetchRequest())
            
            guard let diarysMO = diaryListMO.first?.diarys else {
                return []
            }
            
            for diaryMO in diarysMO {
                guard let diary = diaryMO as? DiaryMO,
                      let title = diary.title,
                      let body = diary.body else {
                    return []
                }
                
                let newDiary = Diary(
                    title: title,
                    body: body,
                    createdAt: Int(diary.createdAt))
            
                diarys.append(newDiary)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return diarys
    }
}
