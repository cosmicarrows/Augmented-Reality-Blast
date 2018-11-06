//
//  ViewController.swift
//  AR Blast
//
//  Created by Laurence Wingo on 11/4/18.
//  Copyright © 2018 Cosmic Arrows, LLC. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showBoundingBoxes]
        self.sceneView.session.run(configuration)
        self.sceneView.automaticallyUpdatesLighting = true
        //self.sceneView.session.run(configuration, options: [])
        
    }

    @IBAction func add(_ sender: UIButton) {
        let node = SCNNode.init()
        //node.geometry = SCNPlane.init(width: 0.1, height: 0.1)
        //node.geometry = SCNBox.init(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //node.geometry = SCNTube.init(innerRadius: 0.1, outerRadius: 0.1, height: 0.1)
        node.geometry = SCNPlane.init(width: 0.1, height: 0.1)
        
        
        let microsoft = UIImage.init(named: "microsoft")
        node.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        node.geometry?.firstMaterial?.diffuse.contents = microsoft
        //let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //let z = randomNumbers(firstNum: 0.3, secondNum: 0.3)
        //node.position = SCNVector3.init(x, y, z)
        node.position = SCNVector3.init(0, 0, -0.3)
        node.eulerAngles = SCNVector3.init(Float(-190.degreesToRadians),0,0)
        self.sceneView.scene.rootNode.addChildNode(node)
        //positioning of the node
        
    }
    
    @IBAction func addKendrick(_ sender: UIButton) {
        let node = SCNNode.init()
        node.geometry = SCNBox.init(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let kendrick = UIImage.init(named: "kendrick")
        node.geometry?.firstMaterial?.diffuse.contents = kendrick
        self.sceneView.scene.rootNode.addChildNode(node)
        //positioning of the node
        node.position = SCNVector3.init(0.2, 0, -0.3)
    }
    @IBAction func reset(_ sender: UIButton) {
        restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [ARSession.RunOptions.resetTracking, ARSession.RunOptions.removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        let myDivisor = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let myAbsAndMin = abs(firstNum - secondNum) + min(firstNum, secondNum)
        return myDivisor * myAbsAndMin
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) + .pi/180}
}

