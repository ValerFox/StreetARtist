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
    
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var blackWhiteButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    let canvasView = PKCanvasView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        view.addSubview(backgroundImage)
        view.addSubview(canvasView)
        view.addSubview(saveButton)
        view.addSubview(takePhotoButton)
        view.addSubview(blackWhiteButton)
        
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
        let saveAlert = UIAlertController(title: "SAVING STATE", message: "Your drawing has been saving in your gallery!", preferredStyle: .alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(saveAlert, animated: true)
    }
    
    @IBAction func takePhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func changeColorBackground(_ sender: UIButton) {
        //        if canvasView.backgroundColor == .white {
        //            canvasView.backgroundColor = .black
        //        } else {
        //            canvasView.backgroundColor = .white
        //        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let immagineAcquisita = info[.editedImage] as? UIImage {
            backgroundImage.image = immagineAcquisita
            picker.dismiss(animated: true)
        }
    }
}
