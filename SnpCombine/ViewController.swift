//
//  ViewController.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 19/09/22.
//

import UIKit
import SwiftUI
import SnapKit
import FirebaseStorage
import SceneKit

class ViewController: UIViewController {
    
    let contentView = UIHostingController(rootView: ContentView())

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        view.addSubview(contentView.view)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
}


