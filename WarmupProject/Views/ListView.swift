//
//  ListView.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/27/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class ListView: UIView {
    var pickerHeightMultiPlier: CGFloat = 0.08
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .clear
        return pv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumCell")
        tv.backgroundColor = .clear
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .groupTableViewBackground
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
        let ListObjects = [pickerView, tableView] as [UIView]
        ListObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate([
            //pickerView
            
            pickerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            pickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: pickerHeightMultiPlier),
            
            //tableview
            tableView.topAnchor.constraint(equalTo: pickerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

}
