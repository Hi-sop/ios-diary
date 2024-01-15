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
            let diaryListMO = try delegate.persistentContainer.viewContext.fetch(DiaryListMO.fetchRequest())
            
            guard let diarysMO = diaryListMO.first?.diarys else {
                return []
            }
            
            for diaryMO in diarysMO {
                guard let diary = diaryMO as? Diary else {
                    return []
                }
                
                let diaryData = Diary(
                    title: diary.title,
                    body: diary.body,
                    createdAt: diary.createdAt)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return diary
    }
}
