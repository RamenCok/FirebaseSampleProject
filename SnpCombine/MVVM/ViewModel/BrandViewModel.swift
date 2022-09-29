//
//  BrandViewModel.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 26/09/22.
//

import Foundation
import Firebase
import Combine

class BrandViewModel{
    
    private var cancellables = Set<AnyCancellable>()
    
    var brands: [Brand] = []
    
    func fetchBrands() {
        let COLLECTION_BRAND = Firestore.firestore().collection("brand").document("deFuTc2cp8e2LIQbJRKA")
        COLLECTION_BRAND.getDocument { snapshot, error in
            let dictionary = snapshot?.data()
            let brandData = Brand(dictionary: dictionary!)
            self.brands.append(brandData)
            print(self.brands)
        }
    }
}
