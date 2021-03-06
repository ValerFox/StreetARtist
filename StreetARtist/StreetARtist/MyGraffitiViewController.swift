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
    
    var graffitinumber: Int = 0
    var graffiti: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        do {
            let items = try fm.contentsOfDirectory(atPath: documentsDirectory)
            print(items.count)
            graffitinumber = items.count
            
            var x: Int = 0
            for _ in items {
                let imagePath = (documentsDirectory as NSString).appendingPathComponent(items[x])
                graffiti.append(UIImage(contentsOfFile: imagePath)!)
                x = x+1
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

//// MARK:- collectionView extesion
extension MyGraffitiViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graffitinumber
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CollectionViewCell

        cell.cellImage.image = graffiti[indexPath.row]

        cell.cellImage.contentMode = .scaleAspectFit

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        previewView.image = graffiti[indexPath.item]
        AppData.shared.graffititemp = graffiti[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
}
