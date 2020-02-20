//
//  MyGraffitiViewController.swift
//  StreetARtist
//
//  Created by Valerio Volpe on 20/02/2020.
//  Copyright © 2020 Valerio Volpe. All rights reserved.
//

import UIKit

class MyGraffitiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var graffiti: [UIImage] = [UIImage(named: "StreetAppIcon.png")!]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graffiti.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectionViewCell
        
        cell.cellImage.image = graffiti[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: 150.0, height: 150.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
