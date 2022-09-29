//
//  BrandListView.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 26/09/22.
//

import UIKit
import SnapKit
import Combine

class BrandListView: UIViewController {
    
    let vm = BrandViewModel()
    let publisherBrand = PassthroughSubject<String, Never>()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        vm.fetchBrands()
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}



