//
//  ColorCell.swift
//  whosupdev
//
//  Created by Sophie Romanet on 23/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import SDWebImage

class ColorCell: SwipingCarouselCollectionViewusercell {
    

    @IBOutlet weak var ImgView: UIImageView!
    var isHeightCalculated: Bool = false
    
    
    /*var name: String = "" {
        didSet {
            nameLabel.text = name
            nameLabel.frame = CGRect(x: 77, y: 280, width: 220, height:31)
            nameLabel.textColor = .white
            nameLabel.shadowOffset = CGSize(width: 5, height: 5)
            
        }
    }*/
    override func initView(canvas: UIView, collectionViews: UICollectionView, firstcollection: UICollectionView, viewseconde: UIView) {
        // collectionViews.reloadData()
        super.initView(canvas: canvas, collectionViews: collectionViews, firstcollection: firstcollection, viewseconde: viewseconde)
    }
    func getImgProfil(_imgView: String) {
        
        //ImgView.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_imgView)"), placeholderImage: UIImage(named: "placeholder.png"))
        ImgView.image = User.sharedInstance.getmediumPhoto()
        //ImgView.frame = CGRect(x: 0, y: 0, width: 111, height:109)
        ImgView.setBorder(5, color: .white)
        ImgView.layer.cornerRadius = ImgView.frame.height/2
        ImgView.clipsToBounds = true
        
    }


}
