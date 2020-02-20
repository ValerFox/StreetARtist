//
//  CameraViewController.swift
//  StreetARtist
//
//  Created by Valerio Volpe on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let wallImage = UIImageView()
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func takePhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let takenPhoto = info[.editedImage] as? UIImage {
                CameraViewController.wallImage.image = takenPhoto
                picker.dismiss(animated: true)
            }
          let pencilViewController = self.storyboard?.instantiateViewController(withIdentifier: "pencilViewController") as! PencilViewController

            self.navigationController!.pushViewController(pencilViewController, animated: true)
        }

}
