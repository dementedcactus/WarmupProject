//
//  DetailView.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/28/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class DetailView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var albumCoverImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "placeholderImage")
        return view
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
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        setupBlurEffectView()
        setupDismissView()
        setupAndConstrainObjects()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupDismissView() {
        addSubview(dismissView)
    }
    
    private func setupAndConstrainObjects() {
        
        //ARRAY MUST BE ON ORDER
        let allDetailViewObjects = [albumCoverImageView] as [UIView]
        
        allDetailViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            
            //albumCoverImageView
            albumCoverImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            albumCoverImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            albumCoverImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.90),
            albumCoverImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.80),
            
            ])
    }
}
