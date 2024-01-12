//
//  DiaryMO+CoreDataProperties.swift
//  Diary
//
//  Created by Hisop on 2024/01/12.
//
//

import Foundation
import CoreData


extension DiaryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryMO> {
        return NSFetchRequest<DiaryMO>(entityName: "Diary")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var createAt: Int16

}

extension DiaryMO : Identifiable {

}