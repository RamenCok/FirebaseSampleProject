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
import JGProgressHUD

class sceneKitUIKit: UIViewController {
    
    let filename = "LemonMeringuePie.usdz"
    
    private lazy var sceneKitView: SCNView = {
        let view = SCNView()
        view.allowsCameraControl = true
        
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var buttonAR: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AR View", for: .normal)
        button.addTarget(self, action: #selector(handleArView), for: .touchUpInside)
        return button
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
    
    @objc func handleArView() {
        let rootVC = ARView()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .pageSheet
        present(navVC, animated: true)
    }
        
    func fetchModels() async {
        do {
            let hud = JGProgressHUD()
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            
            let storage = Storage.storage().reference()
            let modelPath = storage.child("3dmodels/\(filename)")
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let tempDirectory = URL.init(fileURLWithPath: paths, isDirectory: true)
            let targetUrl = tempDirectory.appendingPathComponent("\(filename)")
            
            modelPath.write(toFile: targetUrl) { (url, error) in
                if error != nil {
                    print("ERROR: \(error!)")
                }else{
                    hud.dismiss()
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
        let targetUrl = tempDirectory.appendingPathComponent("\(filename)")
        
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
        
        setupAR()
    }
    
    func setupAR() {
        view.addSubview(buttonAR)
        buttonAR.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(250)
            make.width.height.equalTo(view.snp.width)
        }
    }
}
