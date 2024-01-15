//
//  DiaryListMO+CoreDataProperties.swift
//  Diary
//
//  Created by Hisop on 2024/01/15.
//
//

import Foundation
import CoreData


extension DiaryListMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryListMO> {
        return NSFetchRequest<DiaryListMO>(entityName: "DiaryList")
    }

    @NSManaged public var diarys: NSSet?

}

// MARK: Generated accessors for diarys
extension DiaryListMO {

    @objc(addDiarysObject:)
    @NSManaged public func addToDiarys(_ value: DiaryMO)

    @objc(removeDiarysObject:)
    @NSManaged public func removeFromDiarys(_ value: DiaryMO)

    @objc(addDiarys:)
    @NSManaged public func addToDiarys(_ values: NSSet)

    @objc(removeDiarys:)
    @NSManaged public func removeFromDiarys(_ values: NSSet)

}

extension DiaryListMO : Identifiable {

}
