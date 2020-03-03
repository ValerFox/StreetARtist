//
//  ARViewController.swift
//  StreetARtist
//
//  Created by Gennaro Casolaro on 26/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
 
    @IBOutlet weak var exitButton: UIButton!
    
  let arView: ARSCNView = {
    let view = ARSCNView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let configuration = ARWorldTrackingConfiguration()

  var graffiti: [UIImage] {
        return AppData.shared.graffitio
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    view.insertSubview(arView, at: 0)
    view.insertSubview(exitButton, at: 1)
    
    arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    
    
    
    
    configuration.planeDetection = .vertical
    arView.session.run(configuration, options: [])
    arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    
    arView.delegate = self
  }
    
    @IBAction func exitAction(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
    }
   
    func degreesToRadians(x: Int) -> Double {
        return Double(x) * .pi/180
    }
   
  func create(anchor: ARPlaneAnchor) -> SCNNode {
    let node = SCNNode()
    node.name = "wall"
    node.eulerAngles = SCNVector3(degreesToRadians(x: 270), 0, 0)
    node.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
    node.geometry?.firstMaterial?.diffuse.contents = graffiti[0]
    node.geometry?.firstMaterial?.isDoubleSided = true
    node.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
    return node
  }
  
  func removeNode(named: String) {
    arView.scene.rootNode.enumerateChildNodes { (node, _) in
      if node.name == named {
        node.removeFromParentNode()
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
    print("New plane anchor found with extent:", anchorPlane.extent)
    let planeNode = create(anchor: anchorPlane)
    node.addChildNode(planeNode)
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
    print("Plane anchor updated with extent:", anchorPlane.extent)
    removeNode(named: "wall")
    let planeNode = create(anchor: anchorPlane)
    node.addChildNode(planeNode)
  }

  func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
    print("Plane anchor removed with extent:", anchorPlane.extent)
    removeNode(named: "wall")
  }

}

