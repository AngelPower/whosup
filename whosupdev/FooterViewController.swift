//
//  ViewController.swift
//  Cards_Layout
//
//  Created by kdas on 11/2/16.
//  Copyright © 2016 Classic Tutorials. All rights reserved.
//

import UIKit
//import InfiniteScrolling

extension UIView {
    public func setBorder(_ width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}


class FooterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cards: UICollectionView!
   
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    fileprivate var photosUrlArray = [String]()
    fileprivate var HachtagUrlArray = [String]()
    
    let WINDOW_WIDTH = UIScreen.main.bounds.width
    let WINDOW_HEIGHT = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        photosUrlArray = ["lapin","Int","lapin","Int"]
        HachtagUrlArray = ["#achatdelapin","#beerpong","#achatdelapin","#beerpong"]
        
        self.automaticallyAdjustsScrollViewInsets = false        // Do any additional setup after loading the view, typically from a nib.
        cards?.delegate = self
        cards?.dataSource = self
        
           cards.backgroundColor = UIColor(red:0.68, green:0.23, blue:0.72, alpha:1.0)
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    func photoForIndexPath(_ indexPath: IndexPath) -> String {
        return photosUrlArray[indexPath.row]
    }
    
    
    func reversePhotoArray(_ photoArray:[String], startIndex:Int, endIndex:Int){
        if startIndex >= endIndex{
            return
        }
        swap(&photosUrlArray[startIndex], &photosUrlArray[endIndex])
        
        reversePhotoArray(photosUrlArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrlArray.count
    }
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath)
        configureCell(cell: cell as! MyCell, _indexPath: indexPath)
     
        return cell
        
    }

    
    func configureCell(cell: MyCell, _indexPath: IndexPath) {
        
        let photoName = photoForIndexPath(_indexPath)
        
        let namehach = HachtagUrlArray[_indexPath.row]
         let image1 = UIImage(named: photoName)
        // let imageView = UIImageView(image: image1!)
       
        cell.getImgProfil(_imgView: image1!)
        
        cell.name = namehach
    }
    


    
  /*  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth:Float = 310 + 25;
        
        let currentOffSet:Float = Float(scrollView.contentOffset.x)
        
        print(currentOffSet)
        let targetOffSet:Float = Float(targetContentOffset.pointee.x)
        
        print(targetOffSet)
        var newTargetOffset:Float = 0
        
        if(targetOffSet > currentOffSet){
            newTargetOffset = ceilf(currentOffSet / pageWidth) * pageWidth
        }else{
            newTargetOffset = floorf(currentOffSet / pageWidth) * pageWidth
        }
        
        if(newTargetOffset < 0){
            newTargetOffset = 0;
        }else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffSet)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: 0), animated: true)
        
    }*/
    
    
   /* override var prefersStatusBarHidden : Bool {
        return true
    }*/
    
}



extension FooterViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size:CGSize = CGSize(width: (WINDOW_WIDTH), height: (WINDOW_WIDTH)*1.203460)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}



extension FooterViewController:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate where the collection view should be at the right-hand end item
        let fullyScrolledContentOffset:CGFloat = cards.frame.size.width * CGFloat(photosUrlArray.count - 1)
        if (scrollView.contentOffset.x >= fullyScrolledContentOffset) {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            if photosUrlArray.count>2{
                reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 1)
                reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: 1)
                reversePhotoArray(photosUrlArray, startIndex: 2, endIndex: photosUrlArray.count - 1)
                let indexPath : IndexPath = IndexPath(row: 1, section: 0)
                cards.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
        else if (scrollView.contentOffset.x == 0){
            
            if photosUrlArray.count>2{
                reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 1)
                reversePhotoArray(photosUrlArray, startIndex: 0, endIndex: photosUrlArray.count - 3)
                reversePhotoArray(photosUrlArray, startIndex: photosUrlArray.count - 2, endIndex: photosUrlArray.count - 1)
                let indexPath : IndexPath = IndexPath(row: photosUrlArray.count - 2, section: 0)
                cards.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
    }
}


class MyCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ImageProfil: UIImageView!
    
   
    var name: String = "" {
        didSet {
            nameLabel.text = name
            nameLabel.frame = CGRect(x: 77, y: 280, width: 220, height:31)
            nameLabel.textColor = .white
            nameLabel.shadowOffset = CGSize(width: 5, height: 5)
            
        }
    }
    
    func getImgProfil(_imgView: UIImage) {
    
        ImageProfil.image = _imgView
        ImageProfil.frame = CGRect(x: 72, y: 80, width: 207, height:207)
        ImageProfil.setBorder(10, color: .white)
        ImageProfil.layer.cornerRadius = 60
        ImageProfil.clipsToBounds = true

    }
  
}


