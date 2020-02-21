//
//  MyGraffitiViewController.swift
//  StreetARtist
//
//  Created by Valerio Volpe on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import UIKit

class MyGraffitiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var galleryView: UICollectionView! //GalleryCollection
//    @IBOutlet weak var storedView: UIImageView!
    @IBOutlet weak var previewView: UIImageView!      //ImageShowed
//    @IBAction func tapAction(_ sender: Any) {
//    }
    
    var graffiti: [UIImage] = [UIImage(named: "soccer-field")!, UIImage(named: "soccer-field")!]
    
    //-----------------------------------CollectionView---------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graffiti.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectionViewCell
        
        cell.cellImage.image = graffiti[indexPath.row]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//       return CGSize(width: 150.0, height: 150.0)
//    }
    //---------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        .isUserInteractionEnabled = true
//        CollectionViewCell.cellImage.addGestureRecognizer(tapGestureRecognizer)
//        }
//
//        @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//        {
//            let tappedImage = tapGestureRecognizer.view as! UIImageView
//
//            previewView.image = storedView.image
        }
    }

