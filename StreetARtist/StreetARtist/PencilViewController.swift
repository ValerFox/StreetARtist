//
//  PencilViewController.swift
//  StreetARtist
//
//  Created by Alessandra Montanino on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//
import UIKit
import PencilKit

class PencilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    @IBOutlet weak var confirmButton: UIButton!
    
    let canvasView = PKCanvasView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------CanvasLoad-------------------------
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        CameraViewController.wallImage.frame = CGRect(x: 50, y: 50, width: 1000, height: 1000)
        
        //------------------Subviews-----------------------
        view.insertSubview(CameraViewController.wallImage, at: 0)
        view.insertSubview(canvasView, at: 1)
        
        //------------------CanvasConstraints--------------------------
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //-------------------ToolPickerLoad------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    //------------------ClearBackground-------------------------
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            CameraViewController.wallImage.image = nil
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        //saveToPhotoAlbum(imageToSave: image)
        AppData.shared.graffiti.append(image)
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Attention", message: "The artwork is not saved. You will lose it.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Exit anyway", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func saveToPhotoAlbum(imageToSave: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, nil, nil)
        
        let saveAlert = UIAlertController(title: "SAVING STATE", message: "Your drawing has been saving in your gallery!", preferredStyle: .alert)

        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(saveAlert, animated: true)
    }
}
