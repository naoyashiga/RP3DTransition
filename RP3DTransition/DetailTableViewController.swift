//
//  DetailTableViewController.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    private let tableCellNibName = String(DetailTableViewCell)
    private let tableCount = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.applyCellNib(cellNibName: tableCellNibName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellNibName, forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.titleLabel.text = "title \(indexPath.row)"
        
        return cell
    }
}
