//
//  MyGraffitiViewController.swift
//  StreetARtist
//
//  Created by Valerio Volpe on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import UIKit

class MyGraffitiViewController: UIViewController {
    
    @IBOutlet weak var galleryView: UICollectionView! //GalleryCollection
    @IBOutlet weak var previewView: UIImageView! //ImageShowed
    
    /// variabile computata
    var graffiti: [UIImage] {
        return AppData.shared.graffiti
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //previewView.image = graffiti[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

// MARK:- collectionView extesion
extension MyGraffitiViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graffiti.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectionViewCell
        
        cell.cellImage.image = graffiti[indexPath.row]
        
        cell.cellImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        previewView.image = graffiti[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
}
