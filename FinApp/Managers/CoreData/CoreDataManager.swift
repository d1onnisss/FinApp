//
//  CoreDataManager.swift
//  FinApp
//
//  Created by Alexey Lim on 24/6/24.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func addAccounting(id: UUID, title: String, amount: Double, date: Date, category: String, image: String, color: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "AccountingModel", in: context) else {
            return
        }
        let accountingModel = AccountingModel(entity: entity, insertInto: context)
        accountingModel.id = id
        accountingModel.title = title
        accountingModel.amount = amount
        accountingModel.date = date
        accountingModel.category = category
        accountingModel.image = image
        accountingModel.color = color
        
        appDelegate.saveContext()
    }
    
    func fetchExpenses() -> [AccountingModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountingModel")
        do {
            let accountings = try context.fetch(fetchRequest) as! [AccountingModel]
            return accountings.filter { $0.category == "expenses" }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func fetchIncomes() -> [AccountingModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountingModel")
        do {
            let accountings = try context.fetch(fetchRequest) as! [AccountingModel]
            return accountings.filter { $0.category == "incomes" }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateAccounting(id: UUID, amount: Double, title: String, image: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountingModel")
        do {
            guard let accountings = try context.fetch(fetchRequest) as? [AccountingModel], let accounting = accountings.first(where: { $0.id == id }) else {
                return
            }
            accounting.amount = amount
            accounting.title = title
            accounting.image = image
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccounting(id: UUID) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountingModel")
        do {
            guard let accountings = try context.fetch(fetchRequest) as? [AccountingModel], let accounting = accountings.first(where: { $0.id == id }) else {
                return
            }
            context.delete(accounting)
            appDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AccountingModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
