//
//  GroupViewController.swift
//  GroupIt
//
//  Created by Saumeel Gajera on 8/15/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let todoCategoryManager = TodoCategoryManager()
    let todoItemManager = TodoItemManager()
    let categoryDataUtil = TodoCategoryDataUtil()
    let categoryMapper = TodoCategoryMapper()
    
    let imageCategoryManager = ImageCategoryManager()
    let imageItemManager = ImageItemManager()
//    var toDoCategories : [TodoCategory]?
    
    var group : Group?
    
    let id = "2VhIUxULKz"
    
    func makeNetworkCallToRefreshTheTableView(){
        todoCategoryManager.getAllTodoCategories({ (todoCategories : [Category], error : NSError?) in
            self.group?.categories = todoCategories
            self.tableView.reloadData()
        })
    }
    
    func onAddButton() {
        print("adding a new category ... ")
        let alertController = UIAlertController(title: "Add Category", message: "Choose Wisely", preferredStyle: .ActionSheet)
        
        // create a dismiss action
        let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        // create an OK action
        let toDoAction = UIAlertAction(title: "ToDo", style: .Destructive) { (action) in
            let category = TodoCategory()
            self.performSegueWithIdentifier(Constants.CREATE_CATEGORY_SEQUE, sender: category)
//            self.performSegueWithIdentifier(Constants.SETUP_GROUP_TODO_CATEGORY_SEGUE, sender: self)
        }
        alertController.addAction(toDoAction)
        
        let pollAction = UIAlertAction(title: "Poll", style: .Destructive) { (action) in
            //call poll setup
        }
        alertController.addAction(pollAction)
        
        let imagesAction = UIAlertAction(title: "Images", style: .Destructive) { (action) in
            let category = ImageCategory()
            self.performSegueWithIdentifier(Constants.CREATE_CATEGORY_SEQUE, sender: category)
            //call images setup
        }
        alertController.addAction(imagesAction)
        presentViewController(alertController, animated: true) {
            print("alert presented!")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = group?.groupName
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group?.categories?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
        let category = self.group?.categories![indexPath.row]
        populateCategoryCell(cell, category: category!)
        cell.delegate = self
        return cell
    }
    
    func populateCategoryCell(categoryCell : CategoryCell, category : Category) {
        categoryCell.idLabel.text = category.categoryId
        categoryCell.categoryName.text = category.categoryName
        categoryCell.categoryTypeLabel.text = category.categoryType.rawValue
        categoryCell.category = category
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let category = self.group?.categories![indexPath.row]
        let categoryType = (category?.categoryType)!
        switch categoryType {
        case .TODO:
            performSegueWithIdentifier(Constants.READ_GROUP_TODO_CATEGORY_SEGUE, sender: category)
            break
        case .POLL:
//            performSegueWithIdentifier(Constants.READ_GROUP_POLL_CATEGORY_SEGUE, sender: category)
            break
        case .IMAGES:
            performSegueWithIdentifier(Constants.GROUP_TO_IMAGE_CATEGORY_SEGUE, sender: category)
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("deleting ...")
            let categoryToDelete = self.group?.categories![indexPath.row]
            self.group?.categories?.removeAtIndex(indexPath.row)
            todoCategoryManager.deleteTodoCategoryById((categoryToDelete?.categoryId)!, completion: { (deleted : Bool, error : NSError?) in
                if error == nil {
                    print(deleted)
                } else {
                    print(error)
                }
            })
            self.tableView.reloadData()
        }
    }
    
    @IBAction func onGetButton(sender: UIButton){
        print("get by id")
        todoCategoryManager.getTodoCategoryById(id) { (todoCategory, error) in
            if error == nil {
                print(todoCategory)
            }else {
                print(error)
            }
        }
    }
    
    @IBAction func onGetAllButton(sender: UIButton){
        print("on get all button")
        makeNetworkCallToRefreshTheTableView()
    }
    
    @IBAction func onDeleteButton(sender: UIButton){
        print("on delete button")
        todoCategoryManager.deleteTodoCategoryById(id) { (deleted: Bool, error: NSError?) in
            if error == nil {
                print(deleted)
                self.makeNetworkCallToRefreshTheTableView()
            } else {
                print(error)
            }
        }
    }
    
    @IBAction func onDeleteAllButton(sender: UIButton){
        print("All Delete")
        todoCategoryManager.deleteAllCategories { (error: NSError?) in
            if error == nil {
                print ("deleted all")
                self.makeNetworkCallToRefreshTheTableView()
            }else {
                print(error)
            }
        }
    }
    
    @IBAction func onupdateButton(sender: UIButton){
        print("on update button ")
    }
    
    
    @IBAction func onAddCategoryButton(sender: AnyObject) {
        print("on add category button")
        let alertController = UIAlertController(title: "Add Category", message: "Choose Wisely", preferredStyle: .ActionSheet)

        // create a dismiss action
        let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        // create an OK action
        let toDoAction = UIAlertAction(title: "ToDo", style: .Destructive) { (action) in
            self.performSegueWithIdentifier(Constants.SETUP_GROUP_TODO_CATEGORY_SEGUE, sender: self)
        }
        alertController.addAction(toDoAction)

        let pollAction = UIAlertAction(title: "Poll", style: .Destructive) { (action) in
            //call poll setup
        }
        alertController.addAction(pollAction)
        
        let imagesAction = UIAlertAction(title: "Images", style: .Destructive) { (action) in
            self.performSegueWithIdentifier(Constants.GROUP_TO_IMAGE_CATEGORY_SEGUE, sender: self)
            //call images setup
        }
        alertController.addAction(imagesAction)
        presentViewController(alertController, animated: true) { 
            print("alert presented!")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        
        if segueIdentifier == Constants.CREATE_CATEGORY_SEQUE {
            let categoryCreateViewController = segue.destinationViewController as! CategoryCreateViewController
            let category = sender as! Category
            categoryCreateViewController.category = category
            categoryCreateViewController.delegate = self
        }
        if segue.identifier == Constants.READ_GROUP_TODO_CATEGORY_SEGUE {
            let todoDetailsVeiwController = segue.destinationViewController as! TodoDetailsViewController
            let category = sender as? Category
            todoItemManager.getAllTodoItemsByCategoryId((category?.categoryId)!, completion: { (todoItems : [TodoItem], error : NSError?) in
                var categoryDictionary = self.categoryMapper.toDictionary(category!)
                categoryDictionary["todoItems"] = todoItems
                let todoCategory = TodoCategory(todoCategoryDictionary: categoryDictionary)
                todoCategory.todoItems = todoItems
                todoDetailsVeiwController.todoCategory = todoCategory
                todoDetailsVeiwController.todoItemsTableView.reloadData()
            })
        }
        if segue.identifier == Constants.GROUP_TO_IMAGE_CATEGORY_SEGUE {
            print("preparing segue from group to image category ... ")
//            let imageDetailsViewController = segue.destinationViewController as! ImageDetailsViewController
//            
        }
    }
}

extension GroupViewController : CategoryCreateDelegate {
    func onSave(category : Category) {
        if (category.categoryId != nil) {
            findAndRemove(category)
        }
//        let categoryType = category.categoryType
//        switch categoryType {
//        case .TODO:
            todoCategoryManager.upsertTodoCategory((group?.groupId)!, todoCategory: category, completion: { (upserted : Bool, category : Category?, error : NSError?) in
                if error == nil {
                    print(upserted)
                    self.group?.categories?.append(category!)
                    self.tableView.reloadData()
                } else {
                    print(error)
                }
            })
//        default:
//            print("default category...")
//        }
    }
    
    func findAndRemove(category : Category) {
        let categoryIndex = findIndex(category)
        if let categoryIndex = categoryIndex {
            self.group?.categories?.removeAtIndex(categoryIndex)
        }
    }
    
    func findIndex(category: Category) -> Int? {
        let categories = self.group?.categories
        for i in 0 ..< categories!.count  {
            let existingCategory = categories![i]
            if existingCategory.categoryId == category.categoryId {
                return i
            }
        }
        return nil
    }

}

extension GroupViewController : CategoryCellDelegate {
    func onLongPress(category : Category) {
        performSegueWithIdentifier(Constants.CREATE_CATEGORY_SEQUE, sender: category)
    }
}


