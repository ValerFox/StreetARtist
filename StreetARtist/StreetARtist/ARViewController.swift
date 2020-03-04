//
//  ARViewController.swift
//  StreetARtist
//
//  Created by Gennaro Casolaro on 26/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//
import SpriteKit
import ARKit

class ARViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    @IBOutlet weak var exitButton: UIButton!
    
    var nostraImmagine: SKSpriteNode?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK:- ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = false
        sceneView.showsNodeCount = false
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetTracking()
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        configuration.automaticImageScaleEstimationEnabled = false
        configuration.isAutoFocusEnabled = true
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK:- Actions
    @IBAction func exitAction(_ sender: UIButton) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ARSKViewDelegate
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        if nostraImmagine != nil { return nil }
        let texture = SKTexture(image: AppData.shared.graffititemp)
        let nostraImmagineNode = SKSpriteNode(texture: texture)
        
        nostraImmagine = nostraImmagineNode

        return nostraImmagineNode
    }
    
    @objc func pinchGesture(_ gesture: UIPinchGestureRecognizer) {
        
        guard let nostraImmagine = nostraImmagine else { return }
        
        switch gesture.state {
        case .changed:
            if (gesture.scale>=1) {
            nostraImmagine.size.width += gesture.scale
                nostraImmagine.size.height += gesture.scale }
            else {
            nostraImmagine.size.width -= gesture.scale*4
                nostraImmagine.size.height -= gesture.scale*4 }
            
            print(gesture.scale)
            
            // let action = SKAction.scale(by: 9, duration: 0.1)
            // nostraImmagine.run(action)
            
        default:break
        }
    }
    
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

//  let arView: ARSCNView = {
//    let view = ARSCNView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()
//
//  let configuration = ARWorldTrackingConfiguration()
//
//  var graffiti: [UIImage] {
//        return AppData.shared.graffitio
//    }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    // Do any additional setup after loading the view, typically from a nib.
//
//    view.insertSubview(arView, at: 0)
//    view.insertSubview(exitButton, at: 1)
//
//    arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//    arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//    arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//
//    configuration.planeDetection = .vertical
//    arView.session.run(configuration, options: [])
//    arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
//
//    arView.delegate = self
//  }
//
//    func degreesToRadians(x: Int) -> Double {
//        return Double(x) * .pi/180
//    }
//
//  func create(anchor: ARPlaneAnchor) -> SCNNode {
//    let node = SCNNode()
//    node.name = "wall"
//    node.eulerAngles = SCNVector3(degreesToRadians(x: 270), 0, 0)
//    node.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
//    node.geometry?.firstMaterial?.diffuse.contents = graffiti[0]
//    node.geometry?.firstMaterial?.isDoubleSided = true
//    node.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
//    return node
//  }
//
//  func removeNode(named: String) {
//    arView.scene.rootNode.enumerateChildNodes { (node, _) in
//      if node.name == named {
//        node.removeFromParentNode()
//      }
//    }
//  }
//
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//  }
//
//  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//    print("New plane anchor found with extent:", anchorPlane.extent)
//    let planeNode = create(anchor: anchorPlane)
//    node.addChildNode(planeNode)
//  }
//
//  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//    print("Plane anchor updated with extent:", anchorPlane.extent)
//    removeNode(named: "wall")
//    let planeNode = create(anchor: anchorPlane)
//    node.addChildNode(planeNode)
//  }
//
//  func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
//    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//    print("Plane anchor removed with extent:", anchorPlane.extent)
//    removeNode(named: "wall")
//  }
//    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
//    print("Plane anchor removed with extent:", anchorPlane.extent)
//    removeNode(named: "wall")
//  }
