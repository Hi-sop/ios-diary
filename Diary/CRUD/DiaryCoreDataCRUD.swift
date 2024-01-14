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
        guard let entity = NSEntityDescription.entity(forEntityName: "Diary", in:  else {
            return
        }
        
        let diaryMO = DiaryMO(entity: entity, insertInto: appDelegate.persistentContainer.viewContext)

        
        diaryMO.setValue(data.id, forKey: "id")
        diaryMO.setValue(data.name, forKey: "name")
        //userMO.setValue(data.jokes, forKey: "jokes")
        
        guard appDelegate.persistentContainer.viewContext.hasChanges else {
            return
        }
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCoreData() -> [User] {
        var users: [User] = []
        
        do {
            let userMOs = try appDelegate.persistentContainer.viewContext.fetch(UserMO.fetchRequest())
            //데이터를 모조리 불러옴 [Diary]
            //tableView써서 index에 맞는 데이터를 테이블뷰에 집어넣을 거기 때문에.
            //세컨드 뷰컨에는 userMOs[indexpath.row] <- 여기에다가 값 넣고 save하게되면 업데이트 완료. 다시 불러올 필요 없이
            //userMO <- 가 참조형이면 제 생각대로 될거같음. 밸류타입이면 안될거같음.
            
            //내용물은 같을 수 있다고 생각하는데, 클래스가 여러개인거죠
            //class1.name == class2.name
            //우린 어차피 한번에 fetch해올거라 상관없지않나? [class1, class2]
            //UUID = 고유하다. 고유한 유저의 데이터를 가져오고 싶어서 쓴다
            
            //내 생각대로면 삭제할때 어떻게 처리되지?
            
            for userMO in userMOs {
                let user = User(id: userMO.id!, name: userMO.name!, jokes: [])
                users.append(user)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return users
    }
    
    func updateCoreData(_ data: User) {
        let request = UserMO.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", data.id as CVarArg)
        //request.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        //"id = %@"를 통해서 찾는데. id = data.id로 찾는다?
        //현재 유저 id와 같은거만 쏙 뽑아다가 리턴해줄게
        
        do {
            let userMOs = try appDelegate.persistentContainer.viewContext.fetch(request)
            
            guard let userMO = userMOs.first else {
                return
            }
            
            userMO.name = data.name
            try appDelegate.persistentContainer.viewContext.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCoreData(_ data: User) {
        let request = UserMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        
        do {
            let userMOs = try appDelegate.persistentContainer.viewContext.fetch(request)
            
            guard let userMO = userMOs.first else {
                return
            }
            
            appDelegate.persistentContainer.viewContext.delete(userMO)
            
            try appDelegate.persistentContainer.viewContext.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
