//
//  ListViewController.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/27/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    // Refresh Controller Object
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Stylesheet.Colors.azure
        return refreshControl
    }()
    
    // View Objects
    let listView = ListView()
    
    // Data Objects
    let feedtypes = ["TOP-ALBUMS","COMING-SOON","NEW-RELEASES"]
    var albumResults = [Result]() {
        didSet {
            DispatchQueue.main.async {
                self.listView.tableView.reloadData()
            }
        }
    }
    
    // Pull To Refresh Method
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.loadTableData()
        self.listView.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //Delegates
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.pickerView.delegate = self
        listView.pickerView.dataSource = self
    }
    
    private func setupViews(){
        // Add View to View Controller
        self.view.addSubview(listView)
        self.listView.tableView.addSubview(self.refreshControl)
        self.view.backgroundColor = .groupTableViewBackground
        
        // Constrain View to View Controller
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.loadTableData()
    }
    
    private func loadTableData() {
        //Closure for loading array with album data
        let completionForAlbumData: ([Result]) -> Void = {albumData in
            self.albumResults = albumData
        }
        let defaultFeed = self.feedtypes[0]
        ListAPIClient.manager.getAlbums(pickerViewString: defaultFeed, success: completionForAlbumData, failure: {print($0)})
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albumResults[indexPath.row]
        // Present Self Dismissing Modal of Album Cover
        let detailVC = DetailViewController()
        detailVC.album = album
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .overCurrentContext
        present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        
        let album = albumResults[indexPath.row]
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.darkText.cgColor
        cell.selectionStyle = .none
        cell.artistTitleLabel.text = " \(album.artistName)"
        cell.releaseDateLabel.text = "\(album.releaseDate)"
        
        //Closure for setting image
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.artistBannerPhotoImage.image = onlineImage
        }
        ImageAPIClient.manager.loadImage(from: album.artworkUrl100 ?? "", completionHandler: setImageToOnlineImage, errorHandler: {print($0)})
        return cell
    }
}

extension ListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return feedtypes.count
    }
}

extension ListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedFeed = feedtypes[row]
        let completionForAlbumData: ([Result]) -> Void = {albumData in
            self.albumResults = albumData
        }
    
        ListAPIClient.manager.getAlbums(pickerViewString: selectedFeed, success: completionForAlbumData, failure: {print($0)})
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return feedtypes[row]
    }
}
