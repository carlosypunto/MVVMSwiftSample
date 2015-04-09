//
//  MasterTableViewController.swift
//  MVVM
//
//  Created by carlos on 8/4/15.
//  Copyright (c) 2015 Carlos García. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    let viewModel = ListViewModel()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let item = viewModel.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.amount

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            viewModel.removePayback(indexPath.row)
            refresh()
        }
    }
    
    // MARK: - IBActions
    
    func refresh() {
        viewModel.refresh()
        tableView.reloadData()
    }
    
    // MARK: - Navigation 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! DetailViewController
        if segue.identifier == "createSegue" {
            vc.viewModel = DetailViewModel(delegate: vc)
        }
        else if segue.identifier == "editSegue" {
            vc.viewModel = DetailViewModel(delegate: vc, index: tableView.indexPathForSelectedRow()!.row)
        }
        
    }
    
}
