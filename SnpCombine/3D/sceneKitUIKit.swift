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
        
        Task.init {
            await fetchModels()
        }
        
        view.addSubview(sceneKitView)
        sceneKitView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.width.height.equalTo(view.snp.width)
        }
    }
        
    func fetchModels() async {
        do {
            let storage = Storage.storage().reference()
            let modelPath = storage.child("3dmodels/AirForce.usdz")
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
            let targetUrl = tempDirectory.appendingPathComponent("AirForce.usdz")
            
            modelPath.write(toFile: targetUrl) { (url, error) in
                if error != nil {
                    print("ERROR: \(error!)")
                }else{
                    print("modelPath.write OKAY")
                    self.setup3DModel()
                }
            }
        }
    }
    
    private func setup3DModel() {
//        guard let urlPath = Bundle.main.url(forResource: "shoe", withExtension: "scn") else { return }
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
        let targetUrl = tempDirectory.appendingPathComponent("AirForce.usdz")
        
        let scene = try! SCNScene(url: targetUrl, options: [.checkConsistency: true])
        
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
}
