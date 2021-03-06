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
    
    let canvasView = PKCanvasView(frame: .zero)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------CanvasLoad-------------------------
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        CameraViewController.wallImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        
        //canvasView.tool = PKInkingTool(.pencil, width: 10)
    }
    
    //-----------------------Exit-X-------------------------------------------
    @IBAction func closeAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirm exit?", message: "You will lose all unsaved progress.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Exit", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    //------------------ClearBackground-------------------------
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            CameraViewController.wallImage.image = nil
        }
    }
    
    //---------------------Save------------------------------
        @IBAction func save(_ sender: Any) {
        
            let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0)
        
            let saveAlert = UIAlertController(title: "Saved!", message: "Your sketch has been saved", preferredStyle: .alert)
            saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(saveAlert, animated: true)
            
        let imgname: String = String(NSDate().timeIntervalSince1970)
        
            
            func saveImage(name:String){
        guard let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
            let imgPath = documentDirectoryPath.appendingPathComponent("\(imgname).png")
        do {
            try image.pngData()?.write(to: imgPath, options: .atomic)
            print("saved ", imgname)
        } catch {
            print(error.localizedDescription)
        }
            }
            saveImage(name: imgname)
    }
    
    //--------------------SendToAR----------------------------
    @IBAction func ARtemp(_ sender: Any) {
        AppData.shared.graffititemp = (canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1.0))
    }
}
