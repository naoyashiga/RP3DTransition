//
//  MenuTableViewController.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    private let tableCellNibName = String(MenuTableViewCell)
    
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
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Table"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellNibName, forIndexPath: indexPath) as! MenuTableViewCell
        
        cell.titleLabel.text = "3DTransition"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = DetailTableViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func backButtonTapped() {
        if let navVC = navigationController as? NavigationController {
            navVC.interactiveTransition = nil
            navVC.popViewControllerAnimated(true)
        }
    }
}
