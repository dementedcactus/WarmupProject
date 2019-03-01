//
//  DetailViewController.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/28/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let detailView = DetailView()
    var album: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        
        //Setup Dismiss Button
        detailView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        loadAlbumCover()
    }
    
    private func loadAlbumCover() {
        guard let album = album else {return}
        let setImageToOnlineImage: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.detailView.albumCoverImageView.image = onlineImage
        }
        ImageAPIClient.manager.loadImage(from: album.artworkUrl100 ?? "", completionHandler: setImageToOnlineImage, errorHandler: {print($0)})
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
