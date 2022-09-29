//
//  ViewController.swift
//  tesstappp
//
//  Created by Kevin Harijanto on 29/09/22.
//

import UIKit
import SceneKit
import ARKit
import SnapKit

class ARView: UIViewController, ARSCNViewDelegate {
    
    private lazy var sceneARView: ARSCNView = {
        let view = ARSCNView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneARView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneARView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "AirForce.usdz")!
        
        // Set the scene to the view
        sceneARView.scene = scene
        
        view.addSubview(sceneARView)
        sceneARView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = AROrientationTrackingConfiguration()

        // Run the view's session
        sceneARView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneARView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
