//
//  ProfilCell.swift
//  whosupdev
//
//  Created by Sophie Romanet on 23/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class ProfilCell: SwipingCarouselCollectionViewCell {
    
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var ImgBulles: UIImageView!

    @IBOutlet weak var ImgBullesPlus: UIImageView!
 
    @IBOutlet weak var ImgBulles2: UIImageView!
    @IBOutlet weak var ImgBulles3: UIImageView!
    @IBOutlet weak var ImgBulles4: UIImageView!
    
    @IBOutlet weak var Btnitemsselect: UIButton!
    @IBOutlet weak var LblHachtag: UILabel!
    
    @IBOutlet weak var LblPlus: UILabel!
    var LblTimersoiree = UILabel()
    var LblTimerSport = UILabel()
    var LblTimerFood = UILabel()
    var LblTimerGame = UILabel()
    var LblTimerAutres = UILabel()
    var LblTimerChill = UILabel()
    var seconds = 180
    var istimerstartSoiree = false
    var timer = Timer()
    let imgviewwhite = UIImageView()
    let imgrond = UIImageView()
    let imglogo = UIImageView()
    let Lblemoticone = UILabel()
   // let LblHachta
    var isTimerSoiree = false
    var isTimerSport = false
    var isTimerFood = false
    var isTimerGame = false
    var isTimerAutres = false
    var isTimerChill = false
    
    
    
    override func prepareForReuse() {
        self.backgroundColor = UIColor.clear
    }
    
  
    
    override func initView(canvas: UIView, collectionViews: UICollectionView, firstcollection: UICollectionView) {
       // collectionViews.reloadData()
        super.initView(canvas: canvas, collectionViews: collectionViews, firstcollection: firstcollection)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        //self.layer.zPosition = 55555555
        layoutIfNeeded()
        
        //print("layoutSubviews")
        
        self.Btnitemsselect.layer.zPosition = 60
        
        ImgBulles.layer.cornerRadius = ImgBulles.frame.height/2
        ImgBulles.setBorder(2, color: .white)
        ImgBulles.layer.frame = CGRect(x: 40, y: 550, width: 40, height: 40)
        
        ImgBulles2.layer.cornerRadius = ImgBulles.frame.height/2
        ImgBulles2.setBorder(2, color: .white)
        ImgBulles2.layer.frame = CGRect(x: 70, y: 550, width: 40, height: 40)
        
        ImgBulles3.layer.cornerRadius = ImgBulles.frame.height/2
        ImgBulles3.setBorder(2, color: .white)
        ImgBulles3.layer.frame = CGRect(x: 90, y: 550, width: 40, height: 40)
        
        ImgBulles4.layer.cornerRadius = ImgBulles.frame.height/2
        ImgBulles4.setBorder(2, color: .white)
        ImgBulles4.layer.frame = CGRect(x: 110, y: 550, width: 40, height: 40)
        
        
        let imgView = UIImage(named: "losblanc") as UIImage?
        imgviewwhite.image = imgView
        imgviewwhite.frame = CGRect(x: 19, y: 15, width: 150, height:150)
        

        ImgBullesPlus.layer.cornerRadius = ImgBulles.frame.height/2
        ImgBullesPlus.setBorder(2, color: .white)
        ImgBullesPlus.layer.frame = CGRect(x: 140, y: 550, width: 40, height: 40)
         LblPlus.layer.frame = CGRect(x: 155, y: 555, width: 25, height: 25)
        
        LblHachtag.layer.frame = CGRect(x: 10, y: 520, width: 220, height: 30)
        //LblHachtag.textColor = UIColor.black
        
 
        ImgView.layer.frame = CGRect(x: 20, y: 335, width: 200, height: 194)
        Btnitemsselect.layer.frame = CGRect(x: 20, y: 460, width: 194, height: 60)
        
        ImgView.addSubview(imgviewwhite)
        ImgView.addSubview(imgrond)
        ImgView.addSubview(LblTimersoiree)
        ImgView.addSubview(LblTimerSport)
        ImgView.addSubview(LblTimerGame)
        ImgView.addSubview(LblTimerFood)
        ImgView.addSubview(LblTimerChill)
        ImgView.addSubview(LblTimerAutres)
        
    }
    
    
    func SetImgsBulles( _img: [String], type: String)
    {
        if(type == "moods")
        {
      

            if(_img.count > 0) {
 
            ImgBulles4.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[0])"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgBulles4.isHidden = false
                
            
                }else{ImgBulles4.isHidden = true}
            
            if(_img.count > 1) {
                 ImgBulles3.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[1])"), placeholderImage: UIImage(named: "placeholder.png"))
                
                ImgBulles3.isHidden = false
            }else{ImgBulles3.isHidden = true}
            
            if(_img.count > 2) {
                
               ImgBulles2.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[2])"), placeholderImage: UIImage(named: "placeholder.png"))
                
                ImgBulles2.isHidden = false
            }else{ImgBulles2.isHidden = true}
            
            if(_img.count > 3) {
                
               ImgBulles.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[3])"), placeholderImage: UIImage(named: "placeholder.png"))
                
                ImgBulles.isHidden = false
            }else{ImgBulles.isHidden = true}
            
            
         
            //ImgBullesPlus.image = _img
             LblPlus.text = "+\(_img.count-4)"
            if (_img.count-4 <= 0) {
                ImgBullesPlus.isHidden = true
                
                LblPlus.isHidden = true
            }else {
                ImgBullesPlus.isHidden = false
                
                LblPlus.isHidden = false
            }

        }
        else
        {
            self.hiddenBulles()
        }
    
    
    }
    
    
    func hiddenBulles() {
        
        
        LblTimersoiree.isHidden = true
        imgrond.isHidden = true
       // imglogo.isHidden = true
        ImgBulles.isHidden = true
        ImgBulles2.isHidden = true
        ImgBulles3.isHidden = true
        ImgBulles4.isHidden = true
        ImgBullesPlus.isHidden = true
        LblPlus.isHidden = true
        imgviewwhite.isHidden = true
        imgrond.isHidden = true
        //ImgView.removeFromSuperview()
        Lblemoticone.isHidden = true
        LblTimerAutres.isHidden = true
        LblTimerChill.isHidden = true
        LblTimerFood.isHidden = true
        LblTimersoiree.isHidden = true
        LblTimerGame.isHidden = true
        LblTimerSport.isHidden = true
    }
    
    
    // MARK : timer
    func runTimer() {
       
        if istimerstartSoiree == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            istimerstartSoiree = true
        }
        
    }
    

    
    func updateTimer() {
        
        if seconds < 1 {
         
            timer.invalidate()
            istimerstartSoiree = false
            //Send alert to indicate "time's up!"
        } else {
          
            seconds -= 1
            TimerManager.sharedInstance.setTimerSoiree(_timer:timeString(time: TimeInterval(seconds)))
            //print(timeString(time: TimeInterval(seconds)))
             self.LblTimersoiree.isHidden = false
            print( timeString(time: TimeInterval(seconds)))
             LblTimersoiree.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        
    }
   
    
    
    func hiddentimer ( _timerselection : UILabel , _timerinactif: [UILabel])
    {
    
        print("hiddentimer")
        
    _timerselection.isHidden = false
        
        for item in _timerinactif {
            
            item.isHidden = true
        
        }
    
    
    }
    
    
    
    func alltimer(_timerinactif: [UILabel])
    {
    
    
        for item in _timerinactif {
            
            item.isHidden = true
            
        }
        
    
    
    
    }
    
    func getImgProfil(_imgView: UIImage, dataitem: DataItem, photoname: String, type: String, view: UICollectionView, viewback: UIView) {
        
                //imgviewwhite.layer.zPosition = 5
       

       //ImgBulles.clipsToBounds = true
        if (type == "moods")
        {
              let realm = try! Realm()
            let m_moodsoiree = realm.objects(Moods.self).filter("mood = %@ ", "soiree".localized).first
          
            if(photoname == "soiree".localized && m_moodsoiree?.statut == "activate"){
                
                let imgView1 = UIImage(named: "SOIREEA") as UIImage?
               
                
                ImgView.image = imgView1
                self.LblTimersoiree.text = TimerManager.sharedInstance.getTimerSoiree()
               
                self.hiddentimer(_timerselection: LblTimersoiree, _timerinactif: [LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
               
                LblTimersoiree.frame = CGRect(x: 0, y: 60, width: 222, height:31)
                LblTimersoiree.textColor = UIColor(red:0.58, green:0.15, blue:0.85, alpha:1.0)
                LblTimersoiree.font = LblTimersoiree.font.withSize(25)
                LblTimersoiree.shadowOffset = CGSize(width: 5, height: 5)
                LblTimersoiree.textAlignment = NSTextAlignment.center
              //  LblTimersoiree.isHidden = false
                imgrond.isHidden = false
                
                let imgView2 = UIImage(named: "rondsoiree") as UIImage?
                imgrond.image = imgView2
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                imgviewwhite.isHidden = true
                imgviewwhite.layer.zPosition = 5
                ImgView.setBorder(0, color: .white)
                isTimerSoiree = true
                Lblemoticone.isHidden = true
               
           
            }
            else if(photoname == "soiree".localized && m_moodsoiree?.statut == "noactive"){
               
               
                ImgView.image = _imgView
                imgrond.isHidden = false
                self.LblTimersoiree.isHidden = true
                let imgView2 = UIImage(named: "rondsoiree") as UIImage?
                imgrond.image = imgView2
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
             
               // LblTimersoiree.isHidden = true
                self.imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
               Lblemoticone.isHidden = true
              
            }
            

            
            let m_moodsport = realm.objects(Moods.self).filter("mood = %@ ", "sport".localized).first
            
            if(photoname == "sport".localized && m_moodsport?.statut == "activate"){
                
                
                self.LblTimerSport.text = TimerManager.sharedInstance.getTimerSport()
                ImgView.addSubview(LblTimerSport)
                
                self.hiddentimer(_timerselection: LblTimerSport, _timerinactif: [LblTimersoiree,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                
                
                LblTimerSport.frame = CGRect(x: 0, y: 60, width: 222, height:31)
                LblTimerSport.textColor = UIColor(red:1.00, green:0.24, blue:0.42, alpha:1.0)
                LblTimerSport.font = LblTimerSport.font.withSize(25)
                LblTimerSport.shadowOffset = CGSize(width: 5, height: 5)
                LblTimerSport.textAlignment = NSTextAlignment.center
                
                Lblemoticone.isHidden = true
                let imgView2 = UIImage(named: "SPORTA") as UIImage?
                
                ImgView.image = imgView2
                
                self.imgviewwhite.isHidden = true
                
                imglogo.isHidden = true
                let imgView6 = UIImage(named: "rondsport") as UIImage?
                imgrond.image = imgView6
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
               

                        //imgviewwhite.isHidden = false
                        ImgView.setBorder(0, color: .white)
                
                
            }
            else if(photoname == "sport".localized && m_moodsport?.statut == "noactive"){
              
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                
                Lblemoticone.isHidden = true
                ImgView.image = _imgView
                imgrond.isHidden = false
                let imgView6 = UIImage(named: "rondsport") as UIImage?
                imgrond.image = imgView6
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
               
                
            }
            

            
            let m_moodfood = realm.objects(Moods.self).filter("mood = %@ ", "food".localized).first
            if(photoname == "food".localized && m_moodfood?.statut == "activate"){
                
                self.hiddentimer(_timerselection: LblTimerFood, _timerinactif: [LblTimerSport, LblTimersoiree,LblTimerGame,LblTimerChill,LblTimerAutres])
                
                
                let imgView2 = UIImage(named: "FOODA") as UIImage?
                ImgView.image = imgView2
                
                Lblemoticone.isHidden = true
                imglogo.isHidden = true
                let imgView4 = UIImage(named: "rondfood") as UIImage?
                imgrond.image = imgView4
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                self.imgviewwhite.isHidden = true
                
                
                    //imgviewwhite.isHidden = false
                    ImgView.setBorder(0, color: .white)
                
                
            }
            else if(photoname == "food".localized && m_moodfood?.statut == "noactive"){
               
                
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                
                Lblemoticone.isHidden = true
                ImgView.image = _imgView
                imgrond.isHidden = false
                let imgView4 = UIImage(named: "rondfood") as UIImage?
                imgrond.image = imgView4
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                
                imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
               
                
            }
            
         
            let m_moodgame = realm.objects(Moods.self).filter("mood = %@ ", "game".localized).first
            if(photoname == "game".localized && m_moodgame?.statut == "activate"){
               
                self.hiddentimer(_timerselection: LblTimerGame, _timerinactif: [LblTimerSport,LblTimerFood, LblTimersoiree,LblTimerChill,LblTimerAutres])
                
                
                let imgView2 = UIImage(named: "GAMEA") as UIImage?
                Lblemoticone.isHidden = true
                ImgView.image = imgView2
                
                imgrond.isHidden = false
                let imgView8 = UIImage(named: "rondgame") as UIImage?
                imgrond.image = imgView8
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                self.imgviewwhite.isHidden = true
                
                  // imgviewwhite.isHidden = false
                    ImgView.setBorder(0, color: .white)
                
            }
            else if(photoname == "game".localized && m_moodgame?.statut == "noactive"){
              
                
                
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                Lblemoticone.isHidden = true
                ImgView.image = _imgView
                imgrond.isHidden = false
                let imgView8 = UIImage(named: "rondgame") as UIImage?
                imgrond.image = imgView8
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                
                imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
                
            }
            
            
            
            
            let m_moodautres = realm.objects(Moods.self).filter("mood = %@ ", "autres".localized).first
            if(photoname == "autres".localized && m_moodautres?.statut == "activate"){
                
                self.hiddentimer(_timerselection: LblTimerAutres, _timerinactif: [LblTimerSport,LblTimerFood,LblTimerGame, LblTimersoiree,LblTimerChill])
                
                let imgView2 = UIImage(named: "OTHERA") as UIImage?
                Lblemoticone.isHidden = true
                ImgView.image = imgView2
                
                
                imgrond.isHidden = false
                let imgView10 = UIImage(named: "rondother") as UIImage?
                imgrond.image = imgView10
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                
                self.imgviewwhite.isHidden = true
                
                    //imgviewwhite.isHidden = false
                    ImgView.setBorder(0, color: .white)
              
            }
            else if(photoname == "autres".localized && m_moodautres?.statut == "noactive"){
                
              
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                
                LblTimersoiree.removeFromSuperview()
                Lblemoticone.isHidden = true
                ImgView.image = _imgView
                imgrond.isHidden = false
                
                let imgView10 = UIImage(named: "rondother") as UIImage?
                imgrond.image = imgView10
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
               
                imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
               
                
                
            }
            
            
            
            
            let m_moodchill = realm.objects(Moods.self).filter("mood = %@ ", "chill".localized).first
            if(photoname == "chill".localized && m_moodchill?.statut == "activate"){
                
                self.hiddentimer(_timerselection: LblTimerChill, _timerinactif: [LblTimerSport,LblTimerFood,LblTimerGame, LblTimersoiree, LblTimerAutres])
                
                let imgView2 = UIImage(named: "CHILLA") as UIImage?
                Lblemoticone.isHidden = true
                ImgView.image = imgView2
                
                let imgView12 = UIImage(named: "rondchill") as UIImage?
                imgrond.image = imgView12
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                
                    imgrond.isHidden = false
                self.imgviewwhite.isHidden = true
                
                   // imgviewwhite.isHidden = false
                    ImgView.setBorder(0, color: .white)
                    ImgView.frame.size = CGSize(width: 220, height: 220)
                
             
            }
            else if(photoname == "chill".localized && m_moodchill?.statut == "noactive"){
              
                self.alltimer(_timerinactif: [LblTimersoiree, LblTimerSport,LblTimerFood,LblTimerGame,LblTimerChill,LblTimerAutres])
                Lblemoticone.isHidden = true
                ImgView.image = _imgView
                imgrond.isHidden = false
                let imgView12 = UIImage(named: "rondchill") as UIImage?
                imgrond.image = imgView12
                imgrond.frame = CGRect(x: 70, y: 150, width: 57, height:57)
                imgviewwhite.isHidden = true
                ImgView.setBorder(0, color: .white)
                ImgView.frame.size = CGSize(width: 220, height: 220)
                
                
            }
         
        }
            // instants
       else if (type == "userprofil"){
            
            ImgView.image = _imgView
               imgrond.isHidden = false
            let imgView2 = UIImage(named: "rondsoiree") as UIImage?
            imgrond.image = imgView2
            imgrond.frame = CGRect(x: 70, y: 100, width: 57, height:57)
            imgrond.layer.zPosition = 1
            self.hiddenBulles()
            ImgView.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(photoname)"), placeholderImage: UIImage(named: "placeholder.png"))
            ImgView.setBorder(10, color: .white)
            ImgView.layer.cornerRadius = ImgView.frame.height/2
            ImgView.frame.size = CGSize(width: 194, height: 194)
         
            
           
            LblHachtag.text  = dataitem.pseudo + " , " + dataitem.age
            
            print(dataitem.hashtag)
            
            if (dataitem.hashtag == "") {
                
                Lblemoticone.text = dataitem.descr
                Lblemoticone.frame = CGRect(x: 80, y: 550, width: 95, height:25)
                Lblemoticone.textColor = .black
                Lblemoticone.alpha = 0.5
                Lblemoticone.font = LblTitle.font.withSize(15)
                Lblemoticone.shadowOffset = CGSize(width: 5, height: 5)
                Lblemoticone.textAlignment = NSTextAlignment.center
                Lblemoticone.backgroundColor = UIColor.white
                Lblemoticone.isHidden = false
                Lblemoticone.layer.cornerRadius = 10
                Lblemoticone.clipsToBounds = true
                

            }else {
                Lblemoticone.text = "#" + dataitem.hashtag
                Lblemoticone.frame = CGRect(x: 23, y: 550, width: 200, height:30)
                Lblemoticone.textColor = .black
                Lblemoticone.font = LblTitle.font.withSize(15)
                Lblemoticone.shadowOffset = CGSize(width: 5, height: 5)
                Lblemoticone.textAlignment = NSTextAlignment.center
                Lblemoticone.backgroundColor = UIColor.white
                Lblemoticone.isHidden = false
                Lblemoticone.layer.cornerRadius = 10
                    Lblemoticone.clipsToBounds = true
                
                }
            
              self.addSubview(Lblemoticone)
            
        }
        else{
            ImgView.image = _imgView
            Lblemoticone.isHidden = true
            //ImgView.frame.size = CGSize(width: 207, height: 207)
            imgviewwhite.isHidden = true
            
             self.hiddenBulles()
            ImgView.setBorder(10, color: .white)
            ImgView.layer.cornerRadius = 30
            ImgView.clipsToBounds = true
            ImgView.frame.size = CGSize(width: 194, height: 194)
            
           
        }
  
        

    }
    
        
    
}
