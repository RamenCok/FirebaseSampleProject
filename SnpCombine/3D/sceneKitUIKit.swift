//
//  sceneKitUIKit.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 23/09/22.
//

import SceneKit
import SceneKit.ModelIO
import UIKit
import SnapKit
import FirebaseStorage

class sceneKitUIKit: UIViewController {
    
    private lazy var sceneKitView: SCNView = {
        let view = SCNView()
        view.allowsCameraControl = true
        
        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup3DModel()
        fetchModels()
        
        view.addSubview(sceneKitView)
        sceneKitView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.width.height.equalTo(view.snp.width)
        }
    }
    
    private func setup3DModel() {
        guard let urlPath = Bundle.main.url(forResource: "shoe", withExtension: "scn") else {
            return
        }
        let scene = try! SCNScene(url: urlPath, options: [.checkConsistency: true])
        
        
        let light = SCNNode()
        light.light = SCNLight()
        light.light?.type = .ambient
        light.light?.temperature = 6700
    
        sceneKitView.scene = scene
        scene.rootNode.addChildNode(light)
        let camera = SCNNode()
        camera.camera = SCNCamera()
        scene.rootNode.addChildNode(camera)
    }
    
    func fetchModels() {
        print("download started")
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("3dmodels/AirForce.usdz")
        fileRef.getData(maxSize: 20*1024*1024) { data, error in
            if error == nil && data != nil{
                
            }
        }
    }
}
