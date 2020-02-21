//
//  CameraViewController.swift
//  StreetARtist
//
//  Created by Valerio Volpe on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let wallImage = UIImageView()           //Background
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        var cameraFlag: Bool = false
//-------------------Camera------------------------------------
    @IBAction func takePhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        cameraFlag=true
    }
//---------------------------------------------------------------
    
// -----------------Gallery-----------------------------------
        @IBAction func takeGalleryButton(_ sender: Any) {
            
            let vcg = UIImagePickerController()
            vcg.delegate = self
            
            vcg.sourceType = UIImagePickerController.SourceType.photoLibrary
            vcg.allowsEditing = false
            present(vcg, animated: true)
            cameraFlag=false
        }
//-----------------------------------------------------------
    
//------------------------------SendBackgroundToNextView-------------------------------
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if (cameraFlag) {
            if let takenPhoto = info[.editedImage] as? UIImage {
                CameraViewController.wallImage.image = takenPhoto
                picker.dismiss(animated: true)
            }
            }else{
                if let takenPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                CameraViewController.wallImage.image = takenPhoto}
                self.dismiss(animated: true, completion: nil)
            }
          let pencilViewController = self.storyboard?.instantiateViewController(withIdentifier: "pencilViewController") as! PencilViewController

            self.navigationController!.pushViewController(pencilViewController, animated: true)
        }
//-------------------------------------------------------------------------------------

}
