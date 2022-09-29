//
//  ViewController.swift
//  SceneKitTest
//
//  Created by Stephen Giovanni Saputra on 26/09/22.
//

import UIKit
import SceneKit
import SceneKit.ModelIO
import SnapKit

class UIKit3D: UIViewController {
    
    // MARK: - Properties
    private lazy var sceneKitView: SCNView = {
        let view = SCNView()
        view.allowsCameraControl = true
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var sceneKitLighting: SCNNode = {
        let light = SCNNode()
        light.light = SCNLight()
        light.light?.type = .ambient
        return light
    }()
    
    private lazy var sceneKitCamera: SCNNode = {
        let camera = SCNNode()
        camera.camera = SCNCamera()
        return camera
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        setupSceneKit()
    }
    
    // MARK: - Selectors
    func setupSceneKit() {
        
        let url = Bundle.main.url(forResource: "AirForce", withExtension: "usdz")!
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        
        sceneKitView.scene = scene
        scene.rootNode.addChildNode(sceneKitLighting)
        scene.rootNode.addChildNode(sceneKitCamera)
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.addSubview(sceneKitView)
        sceneKitView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.width.height.equalTo(view.snp.width)
        }
    }
}
