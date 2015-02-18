//
//  DatesTVC.swift
//  Daily Three
//
//  Created by Mollie on 2/8/15.
//  Copyright (c) 2015 Proximity Viz LLC. All rights reserved.
//

import UIKit

var currentDateIndex = 0

class DatesTVC: UITableViewController {
    
    private var listData = [DateData]()
    private var currentDateData : (titles:[String], details:[String])?
    
    @IBOutlet var dataTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.separatorColor = UIColor(red:0.97, green:0.71, blue:0.05, alpha:1)
        
        listData = ListData.mainData().getDateList()
        
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDateIndex = 0
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // color for highlighted cell background
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.97, green:0.71, blue:0.05, alpha:1)
        cell.selectedBackgroundView = bgColorView
        
        cell.textLabel?.text = listData[indexPath.row].formattedDate
        
        cell.accessoryView?.frame = CGRectMake(0, 0, 44, 44)
        if listData[indexPath.row].done == true {
            cell.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
        } else {
            cell.accessoryView = UIImageView(image: UIImage(named: "Blank"))
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentDateIndex = indexPath.row
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            ListData.mainData().deleteDate(indexPath.row)
            self.listData = ListData.mainData().getDateList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        var completeAction = UITableViewRowAction(style: .Normal, title: "☑") { (action, indexPath) -> Void in
            
            tableView.editing = false
            
            if ListData.mainData().getDateList()[indexPath.row].done == true {
                ListData.mainData().getDateList()[indexPath.row].done = false
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Blank"))
            } else {
                ListData.mainData().getDateList()[indexPath.row].done = true
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = UIImageView(image: UIImage(named: "Checkmark"))
            }
            
            ListData.mainData().setDateList()
            
        }
        
        return [deleteAction, completeAction]
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
