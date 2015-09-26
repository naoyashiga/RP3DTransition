//
//  UITableView+RPExtension.swift
//  RP3DTransition
//
//  Created by naoyashiga on 2015/09/26.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

public extension UITableView {
    public func applyCellNib(cellNibName cellNibName: String) {
        registerNib(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellNibName)
    }
}
