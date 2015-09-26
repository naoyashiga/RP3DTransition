//
//  DetailTableViewController.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIGestureRecognizerDelegate,  UINavigationControllerDelegate {
    
    private let tableCellNibName = String(DetailTableViewCell)
    private let tableCount = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.applyCellNib(cellNibName: tableCellNibName)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let navVC = navigationController as? NavigationController {
            navVC.interactiveTransition = RP3DInterativeTransition()
            navVC.interactiveTransition!.attachToViewController(self)
        }
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