//
//  File.swift
//  StreetARtist
//
//  Created by Gennaro Casolaro on 02/03/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    let zoomLevel: Float = -2.5
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // ANCOR 1
            
            // Create a transform with a translation of 0.2 meters in front a te
            var translation = matrix_identity_float4x4
            translation.columns.3.z = zoomLevel
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
//            let anchor = ARAnchor(transform: .init(3))
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
            
            // ANCOR 2
            var translation2 = matrix_identity_float4x4
                        translation2.columns.3.y = zoomLevel
                        let transform2 = simd_mul(currentFrame.camera.transform, translation)
                        
            // Add a new anchor to the session
            // let anchor = ARAnchor(transform: .init(3))
            let anchor2 = ARAnchor(transform: transform2)
            
            
            sceneView.session.add(anchor: anchor2)
            
            // ANCOR 3
            var translation3 = matrix_identity_float4x4
                        translation3.columns.3.y = zoomLevel
                        let transform3 = simd_mul(currentFrame.camera.transform, translation)
                        
            // Add a new anchor to the session
            // let anchor = ARAnchor(transform: .init(3))
            let anchor3 = ARAnchor(transform: transform3)
            
            
            sceneView.session.add(anchor: anchor3)
        }
    }
}
