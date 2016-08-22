//
//  TodoCategoryManager.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoCategoryManager: NSObject {

    let groupDao = ParseDAO(className: Constants.GROUP_CLASSNAME)
    
    let todoCategoryDao = ParseDAO(className: Constants.TODO_CATEGORY_CLASSNAME)
    let todoCategoryMapper = TodoCategoryMapper()
    
//    func upsertTodoItem(categoryId : String, todoItem : TodoItem, completion : (Bool, NSError?) -> ()) -> Void {
//        todoCategoryDao.getById(categoryId) { (todoCategoryPfObject : PFObject?, error : NSError?) in
//            if error == nil {
//                let todoItemDO = self.todoItemMapper.toTodoItemDO(todoCategoryPfObject as! TodoCategoryDO, todoItem: todoItem)
//                self.todoItemDao.upsert(todoItemDO) { (created : Bool, error : NSError?) in
//                    completion(created, error)
//                }
//            } else {
//                completion(false, error)
//            }
//        }
//    }

    func upsertTodoCategory(groupId : String, todoCategory : TodoCategory, completion : (Bool, NSError?) -> ()) -> Void {
        groupDao.getById(groupId) { (groupPfObject : PFObject?, error : NSError?) in
            if error == nil {
                let todoCategoryDO = self.todoCategoryMapper.toTodoCategoryDO(groupPfObject as! GroupDO, todoCategory: todoCategory)
                self.todoCategoryDao.upsert(todoCategoryDO, completion: { (upserted : Bool, error : NSError?) in
                    completion(upserted, error)
                })
            } else {
                completion(false, error)
            }
        }
    }
    
    func deleteTodoCategoryById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoCategoryDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }

    func getAllTodoCategories(completion : ([TodoCategory], NSError?) -> Void) {
        var todoCategories : [TodoCategory] = []
        todoCategoryDao.getAll { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO)
                        todoCategories.append(todoCategory)
                    }
                }
            }
            completion(todoCategories, error)
        }
    }
    
    func getAllTodoCategoriesByGroupId(groupId : String, completion : ([TodoCategory], NSError?) -> Void) {
        var todoCategories : [TodoCategory] = []
        let parseContext = ParseContext(className: "TodoCategory")
        parseContext.className = Constants.TODO_CATEGORY_CLASSNAME
        parseContext.predicateFormat = "group IN %@"
        parseContext.innerClassName = Constants.GROUP_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(groupId)'"
        todoCategoryDao.getAllByForeignKey(parseContext) { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        todoCategories.append(self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO))
                    }
                }
            }
            completion(todoCategories, error)
        }
    }

    func getTodoCategoryById(id : String, completion : (todoCategory : TodoCategory?, error : NSError?) -> Void) {
        todoCategoryDao.getById(id) { (todoCategoryPfObject: PFObject?, error : NSError?) in
            let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO)
            completion(todoCategory: todoCategory, error: error)
        }
    }
    
    func deleteAllCategories(completion : (NSError?) -> Void) {
        todoCategoryDao.deleteAll { (error: NSError?) in
            completion(error)
        }
    }
}
