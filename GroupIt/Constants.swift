//
//  Constants.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    // ======== Parse ========
    
    static let parseAppId : String = "groupit2"
    static let parseServer : String = "https://groupit2.herokuapp.com/parse"
    
    // ======== Groups ======
    static let GROUPS_STORYBOARD_NAME : String = "Groups"
    static let GROUPS_VIEW_CONTROLLER_ID : String = "GroupsViewController"
    static let GROUPS_NAV_VIEW_CONTROLLER_ID : String = "GroupsNavViewController"
    
    
    // ======== Group ======
    static let GROUP_STORYBOARD_NAME : String = "Group"
    static let GROUP_VIEW_CONTROLLER_ID : String = "GroupViewController"
    static let GROUP_NAV_VIEW_CONTROLLER_ID : String = "GroupViewNavViewController"
    
    static let GROUP_CLASSNAME : String = "Group"
    static let CREATE_CATEGORY_SEQUE = "createCategorySegue"
    
    // ======== TodoCategory ======
    static let TODO_ITEM_CLASSNAME : String = "TodoItem"
    static let TODO_CATEGORY_CLASSNAME : String = "TodoCategory"
    static let TODO_CATEGORY_STORYBOARD_NAME : String = "TodoCategory"
    static let TODO_CATEGORY_VIEW_CONTROLLER_ID : String = "TodoDetailsViewController"
    static let TODO_CATEGORY_NAV_VIEW_CONTROLLER_ID : String = "TodoDetailsNavViewController"
    static let TODO_ITEM_CELL_ID = "TodoItemCell"
    
    static let CREATE_TODO_ITEM_SEQUE = "createTodoItemSeque"

    // ======== PollCategory ======
    
    // ======== ImageCategory ======
    
    
    // ======== Segues ======
    static let READ_GROUP_TODO_CATEGORY_SEGUE : String = "readGroupVCtoDoVCsegue"
    static let SETUP_GROUP_TODO_CATEGORY_SEGUE : String = "setupGroupVCtoDoVCsegue"
    static let READ_GROUPS_GROUP_SEGUE : String = "readGroupsVCtoGroupVCsegue"
}
