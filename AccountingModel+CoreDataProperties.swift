//
//  AccountingModel+CoreDataProperties.swift
//  FinApp
//
//  Created by Alexey Lim on 24/6/24.
//
//

import Foundation
import CoreData


extension AccountingModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountingModel> {
        return NSFetchRequest<AccountingModel>(entityName: "AccountingModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var color: String?

}

extension AccountingModel : Identifiable {

}
