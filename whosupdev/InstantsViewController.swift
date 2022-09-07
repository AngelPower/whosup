//
//  ViewController.swift
//  KDDragAndDropCollectionViews
//
//  Created by Michael Michailidis on 10/04/2015.
//  Copyright (c) 2015 Karmadust. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
import RealmSwift

class DataItem : Equatable {
    
    var indexes : String = ""
    var colour : String = ""
    var type : String = ""
     var age : String = ""
     var hashtag : String = ""
     var descr : String = ""
     var pseudo : String  = ""
     var longitude : String  = ""
     var latitude : String  = ""
    init(indexes : String, colour : String, type : String, age: String, hashtag: String, descr: String, pseudo: String, longitude: String, latitude: String) {
        self.indexes = indexes
        self.colour = colour
        self.type = type
        self.age = age
        self.hashtag = hashtag
        self.descr = descr
        self.pseudo = pseudo
        self.longitude = longitude
        self.latitude = latitude
    }
}


func ==(lhs: DataItem, rhs: DataItem) -> Bool {
    return lhs.indexes == rhs.indexes && lhs.colour == rhs.colour
}

class InstantsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var ViewSeconde: UIView!
    @IBOutlet weak var ViewFirst: UIView!
    @IBOutlet weak var Btnrejoindre: UIButton!
    @IBOutlet weak var Btnproposer: UIButton!
    @IBOutlet weak var firstCollectionView: UICollectionView!{ didSet {
        firstCollectionView.register(MyProfileViewCell.nib, forCellWithReuseIdentifier: MyProfileViewCell.reuseIdentifier)
        }
    }

    @IBOutlet weak var secondCollectionView: UICollectionView!
   // @IBOutlet weak var thirdCollectionView: UICollectionView!
    
    @IBOutlet weak var BtnNotif: UIButton!
   
    @IBOutlet weak var Tfdhachtag: UITextField!
    
    var ProfilUsers : [[DataItem]] = [[DataItem]]()
    var UserPicure : [[DataItem]] = [[DataItem]]()
    var isfirstTimeTransform:Bool = true
    var dragAndDropManager : KDDragAndDropManager?
    var MoodsSoiree: [String] = [String]()
    var MoodsSport: [String] = [String]()
    var MoodsFood: [String] = [String]()
    var MoodsGame: [String] = [String]()
    var MoodsAutre: [String] = [String]()
    var MoodsChill: [String] = [String]()
    var IdSoiree: [String] = [String]()
    var IdSport: [String] = [String]()
    var IdFood: [String] = [String]()
    var IdGame: [String] = [String]()
    var IdAutre: [String] = [String]()
    var IdChill: [String] = [String]()
    var currentCell = String()
    let LblTitle = UILabel()
    let LblTxt1 = UILabel()
    let LblTxt2 = UILabel()
    let ImgBtn = UIButton(type: UIButtonType.custom) as UIButton
    let Btnon = UIButton()
    let imgprofil = UIImageView()
    let imgMoood = UIImageView()
    let Lbname = UILabel()
    let LblTimer = UILabel()
    var seconds = 60
    var isTimerSoiree = String()
    var isTimerSport = String()
    var isTimerFood = String()
    var isTimerGame = String()
    var isTimerAutres = String()
    var isTimerChill = String()
    var isPlusActive = false
    var isPlusActiveSoiree = false
    var isPlusActiveSport = false
    var isPlusActiveFood = false
    var isPlusActiveGame = false
    var isPlusActiveAutres = false
    var isPlusActiveChill = false
    var height : CGFloat!
    var timer = Timer()
    let kHorizontalInsets: CGFloat = 10.0
    let kVerticalInsets: CGFloat = 10.0
    // A dictionary of offscreen cells that are used within the sizeForItemAtIndexPath method to handle the size calculations. These are never drawn onscreen. The dictionary is in the format:
    // { NSString *reuseIdentifier : UICollectionViewCell *offscreenCell, ... }
    var offscreenCells = Dictionary<String, UICollectionViewCell>()

    var delegate: SwipingCarouselDelegate?
    //let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {

        self.initRequete()
        self.initmoodactivate()

        let layout = SwipingCarouselFlowLayout()
        layout.activeDistance = 50
        secondCollectionView.setCollectionViewLayout(layout, animated: false)
        secondCollectionView?.setCollectionViewLayout(SwipingCarouselFlowLayout(), animated: false)
        Btnproposer.layer.zPosition = 1
        Btnrejoindre.layer.zPosition = 1
        BtnNotif.layer.zPosition = 1
        Tfdhachtag.layer.zPosition = 1
        super.viewDidLoad()
    
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        //print(self.Viewback.layer.zPosition)
    
        secondCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        firstCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
     
        secondCollectionView.layer.zPosition = 2
        firstCollectionView.layer.zPosition = 1
        ViewFirst.layer.zPosition = 0
        ViewSeconde.layer.zPosition = 0
        
        // Add Gesture to Cell
        secondCollectionView.setCollectionViewLayout(SwipingCarouselFlowLayout(), animated: false)
      //  secondCollectionView.layer.zPosition = 10
        let realm = try! Realm()
        let listes = realm.objects(ProfilsListe.self)
        try! realm.write ({
            realm.delete(listes)
        })
        
        let colours : [String] = ["lapin","Int","lapin","Int"]
        let colours2 : [String] = [""]
        let ListeMoods:[String] = ["soiree".localized, "sport".localized, "food".localized,"game".localized,"autres".localized,"chill".localized]
        

        var items = [DataItem]()
        
        
        for i in 0...colours.count-1 {
            
            let dataItem = DataItem(indexes: String(i), colour: colours[i], type: "instants", age: "", hashtag: "", descr: "", pseudo: "", longitude: "", latitude: "")
            
                items.append(dataItem)
            let profilsItem = ProfilsListe()
            profilsItem.indexes = String(i)
            profilsItem.name = colours[i]
            profilsItem.type = "instants"
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(profilsItem)
            }
       }
       
 
        
        for i in 0...ListeMoods.count-1 {
            
            
                let dataItem = DataItem(indexes: String(colours.count + i), colour: ListeMoods[i], type: "moods", age: "", hashtag: "", descr: "", pseudo: "", longitude: "", latitude: "")
                
                items.append(dataItem)
                let profilsItem = ProfilsListe()
                profilsItem.indexes = String(colours.count + i)
                profilsItem.name = ListeMoods[i]
                profilsItem.type = "moods"
            
                let realm = try! Realm()
                try! realm.write {
                    realm.add(profilsItem)
                }
            
        }
  
                ProfilUsers.append(items)
        
               var items3 = [DataItem]()
                let dataItem3 = DataItem(indexes: String(0) + ":" + String(0), colour: colours2[0], type: "profilphoto", age: "", hashtag: "", descr: "", pseudo: "", longitude: "", latitude: "")
        
                items3.append(dataItem3)
                UserPicure.append(items3)

     /*   SocketIOManager.sharedInstance.getmajConnectedUser(completionHandler: { (whiteList) -> Void in
            DispatchQueue.main.async { () -> Void in
                
                
                           self.initRequete()
                self.secondCollectionView.reloadData()
                
                
                
            
            }
           
            })
            */
        
        
      
    }
    
    
    //IBAction Btnrejoindre
    
    
    
    @IBAction func ActionRejoindre(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchingActivateMoodViewController") as? MatchingActivateMoodViewController {
            self.present(viewController, animated: true)
        }
        
        
        
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
    
        height = self.secondCollectionView.collectionViewLayout.collectionViewContentSize.height
        print(height)
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    


    func SetImgsBulles( _img: [String], view: UIVisualEffectView)
    {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let ImgBulle1 = UIImageView(frame: outerView.bounds)
        let ImgBulle2 = UIImageView(frame: outerView.bounds)
        let ImgBulle3 = UIImageView(frame: outerView.bounds)
        let ImgBulle4 = UIImageView(frame: outerView.bounds)
        let ImgBulleplus = UIImageView(frame: outerView.bounds)
        let LblPlus = UILabel(frame: outerView.bounds)
        
      
            if(_img.count > 0) {
                
                
                ImgBulle4.clipsToBounds = true
                ImgBulle4.layer.cornerRadius = 20
                ImgBulle4.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[0])"), placeholderImage: UIImage(named: "placeholder.png"))
                ImgBulle4.isHidden = false
                ImgBulle4.frame = CGRect(x: 92, y: 609, width: 40, height:40)
                
            }else{ImgBulle4.isHidden = true}
            
            if(_img.count > 1) {
                ImgBulle3.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[1])"), placeholderImage: UIImage(named: "placeholder.png"))
                ImgBulle3.frame = CGRect(x: 129, y: 609, width: 40, height:40)
                
                ImgBulle3.isHidden = false
                ImgBulle3.layer.cornerRadius = 20
                ImgBulle3.clipsToBounds = true
                ImgBulle3.layer.zPosition = 5
                
            }else{ImgBulle3.isHidden = true}
            
            if(_img.count > 2) {
                
                ImgBulle2.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[2])"), placeholderImage: UIImage(named: "placeholder.png"))
                ImgBulle2.frame = CGRect(x: 166, y: 609, width: 40, height:40)
                ImgBulle2.isHidden = false
                ImgBulle2.layer.cornerRadius = 20
                ImgBulle2.clipsToBounds = true
                ImgBulle2.layer.zPosition = 5
                
               
            }else{ImgBulle2.isHidden = true}
            
            if(_img.count > 3) {
                
                ImgBulle1.sd_setImage(with: URL(string: "http://82.236.159.23:8080\(_img[3])"), placeholderImage: UIImage(named: "placeholder.png"))
                ImgBulle1.frame = CGRect(x: 203, y: 609, width: 40, height:40)
                ImgBulle1.isHidden = false
                ImgBulle1.layer.cornerRadius = 20
                ImgBulle1.clipsToBounds = true
                
                ImgBulle1.isHidden = false
            }else{ImgBulle1.isHidden = true}
            
            
            
            //ImgBullesPlus.image = _img
            LblPlus.text = "+\(_img.count-4)"
            ImgBulleplus.frame = CGRect(x: 243, y: 609, width: 40, height:40)
            let imgView = UIImage(named: "pixels") as UIImage?
            ImgBulleplus.image = imgView
            ImgBulleplus.isHidden = false
            ImgBulleplus.layer.cornerRadius = 20
            ImgBulleplus.clipsToBounds = true
        
            LblPlus.frame = CGRect(x: 250, y: 609, width: 143, height:140)
        
            if (_img.count-4 <= 0) {
              
                ImgBulleplus.isHidden = true
                LblPlus.isHidden = true
                
            }else {
               
                ImgBulleplus.isHidden = false
                LblPlus.isHidden = false
            }
        
            view.addSubview(ImgBulle1)
            view.addSubview(ImgBulle2)
            view.addSubview(ImgBulle3)
            view.addSubview(ImgBulle4)
            view.addSubview(ImgBulleplus)
            view.addSubview(LblPlus)
        
    }


    
    // the controller that has a reference to the collection view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = self.secondCollectionView.contentInset
        let value = (self.view.frame.size.width - (self.secondCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        self.secondCollectionView.contentInset = insets
        self.secondCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    
  
    // MARK : initrequete
    
    
    func initRequete() {
        
        self.MoodsSoiree.removeAll()
        self.IdSoiree.removeAll()
        self.MoodsGame.removeAll()
        self.IdGame.removeAll()
        self.MoodsFood.removeAll()
        self.IdFood.removeAll()
        self.MoodsSport.removeAll()
        self.IdSport.removeAll()
        self.MoodsAutre.removeAll()
        self.IdAutre.removeAll()
        self.MoodsChill.removeAll()
        self.IdChill.removeAll()
        
        
        
        
                 let realm = try! Realm()
        
                    let m_moodSoiree = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["soiree".localized])
                    if (m_moodSoiree.count != 0 ){
                    
                   for index in 0...m_moodSoiree.count-1 {
                        self.MoodsSoiree.append(m_moodSoiree[index].smallPhoto)
                         self.IdSoiree.append(m_moodSoiree[index]._id)
                        }
                    }
    
                    let m_moodgame = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["game".localized])
                   if (m_moodgame.count != 0 ){
                        
                    for index in 0...m_moodgame.count-1 {
                        self.MoodsGame.append(m_moodgame[index].smallPhoto)
                        self.IdGame.append(m_moodgame[index]._id)
                        }
                   }
        

                let m_moodfood = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["food".localized])
        
                   if (m_moodfood.count != 0 ){
            
                    for index in 0...m_moodfood.count-1 {
                        self.MoodsFood.append(m_moodfood[index].smallPhoto)
                        self.IdFood.append(m_moodfood[index]._id)
                        
                    }
                    }
   
                    let m_moodsport = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["sport".localized])
        
                    if (m_moodsport.count != 0 ){
                        
                    for index in 0...m_moodsport.count-1 {
                        self.MoodsSport.append(m_moodsport[index].smallPhoto)
                        self.IdSport.append(m_moodsport[index]._id)
                        
                    }
                    }

                    let m_moodautres = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["autres".localized])
        
        
                    if (m_moodautres.count != 0 ){
                            
                    for index in 0...m_moodautres.count-1 {
                        self.MoodsAutre.append(m_moodautres[index].smallPhoto)
                        self.IdAutre.append(m_moodautres[index]._id)
                        
                    }
        }

                let m_moodchill = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["chill".localized])
        
        
                   if (m_moodchill.count != 0 ){
                                
                    for index in 0...m_moodchill.count-1 {
                        self.MoodsChill.append(m_moodchill[index].smallPhoto)
                        self.IdChill.append(m_moodchill[index]._id)
                        
                    }
                   }
                   /*MoodsManager.sharedInstance.setMoodsSoiree(_moodsoiree: self.MoodsSoiree)
                    MoodsManager.sharedInstance.setMoodsIdSoiree(_moodIdsoiree: self.IdSoiree)
                    
                    MoodsManager.sharedInstance.setMoodsGame(_moodGame: self.MoodsGame)
                    MoodsManager.sharedInstance.setMoodsIdGame(_moodIdgame: self.IdGame)
                    
                    MoodsManager.sharedInstance.setMoodsfood(_moodfood: self.MoodsFood)
                    MoodsManager.sharedInstance.setMoodsIdFood(_moodIdfood: self.IdFood)
                    
                    MoodsManager.sharedInstance.setMoodSport(_moodsport: self.MoodsSport)
                    MoodsManager.sharedInstance.setMoodIdSport(_moodIdsport: self.IdSport)
                    
                    MoodsManager.sharedInstance.setMoodAutres(_moodAutre: self.MoodsAutre)
                    MoodsManager.sharedInstance.setMoodIdAutres(_moodIdAutre: self.IdAutre)
                    
                    MoodsManager.sharedInstance.setMoodChill(_moodChill: self.MoodsChill)
                    MoodsManager.sharedInstance.setMoodIdChill(_moodIdChill: self.IdChill)
                    
                    
                    */
                    
               // }
                
                
           // }
       // })
        
       
   
            
            
        
    }
    
    func initmoodactivate() {
    
    
        let realm = try! Realm()
        //  let profilliste = realm.objects(ProfilsListe.self)
        let idsoiree = realm.objects(ProfilsListe.self).filter("name == %@", "SOIREE").first?.indexes
        let idsport = realm.objects(ProfilsListe.self).filter("name == %@", "SPORT").first?.indexes
        let idfood = realm.objects(ProfilsListe.self).filter("name == %@", "FOOD").first?.indexes
        let idgame = realm.objects(ProfilsListe.self).filter("name == %@", "GAME").first?.indexes
        let idother = realm.objects(ProfilsListe.self).filter("name == %@", "OTHER").first?.indexes
        let idchill = realm.objects(ProfilsListe.self).filter("name == %@", "CHILL").first?.indexes
        
        let mystringint = UserManager.sharedInstance.getIndexActive()
        
        if(mystringint ==  idsoiree){
            ViewFirst.backgroundColor = UIColor(red:0.58, green:0.15, blue:0.85, alpha:1.0)
            
        }
        if(UserManager.sharedInstance.getIndexActive() == idsport){
            ViewFirst.backgroundColor = UIColor(red:1.00, green:0.24, blue:0.42, alpha:1.0)
        }
        if(UserManager.sharedInstance.getIndexActive() == idfood){
            ViewFirst.backgroundColor = UIColor(red:0.06, green:0.93, blue:0.82, alpha:1.0)
        }
        if(UserManager.sharedInstance.getIndexActive() == idgame){
            ViewFirst.backgroundColor = UIColor(red:0.26, green:0.29, blue:0.98, alpha:1.0)
        }
        if(UserManager.sharedInstance.getIndexActive() == idother){
            ViewFirst.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.11, alpha:1.0)
        }
        if(UserManager.sharedInstance.getIndexActive() == idchill){
            ViewFirst.backgroundColor = UIColor(red:0.44, green:0.80, blue:0.99, alpha:1.0)
        }
        
    
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        
    }

    
    //MARK: ImageButtonAction
  
    func imageButtonAction (sender: UIButton) {
        
        
        
        print("tape imageButtonAction")
        
        print(ProfilUsers[0][sender.tag].colour)
        let mymoodMoodActivate = ProfilUsers[0][sender.tag].colour
        _ = [DataItem]()
        
        
        var myindex = 0
        var index = 0
        for dataitemProfil in self.ProfilUsers[0] {
            
            if ( dataitemProfil.colour == mymoodMoodActivate){
                
               myindex = index
        
            
            }
            
            index = index + 1
            
        }
        
        
        print(myindex)
        print(mymoodMoodActivate)
        
      /*  let realm = try! Realm()
        
        let m_moodSoiree = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["soiree".localized])
        if (m_moodSoiree.count != 0 ){
            
            for index in 0...m_moodSoiree.count-1 {
                self.MoodsSoiree.append(m_moodSoiree[index].smallPhoto)
                self.IdSoiree.append(m_moodSoiree[index]._id)
            }
        }
        
        let m_moodgame = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["game".localized])
        if (m_moodgame.count != 0 ){
            
            for index in 0...m_moodgame.count-1 {
                self.MoodsGame.append(m_moodgame[index].smallPhoto)
                self.IdGame.append(m_moodgame[index]._id)
            }
        }
        
        
        let m_moodfood = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["food".localized])
        
        if (m_moodfood.count != 0 ){
            
            for index in 0...m_moodfood.count-1 {
                self.MoodsFood.append(m_moodfood[index].smallPhoto)
                self.IdFood.append(m_moodfood[index]._id)
                
            }
        }
        
        let m_moodsport = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["sport".localized])
        
        if (m_moodsport.count != 0 ){
            
            for index in 0...m_moodsport.count-1 {
                self.MoodsSport.append(m_moodsport[index].smallPhoto)
                self.IdSport.append(m_moodsport[index]._id)
                
            }
        }
        
        let m_moodautres = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["autres".localized])
        
        
        if (m_moodautres.count != 0 ){
            
            for index in 0...m_moodautres.count-1 {
                self.MoodsAutre.append(m_moodautres[index].smallPhoto)
                self.IdAutre.append(m_moodautres[index]._id)
                
            }
        }
        
        let m_moodchill = realm.objects(WhiteList.self).filter("ANY moodsV.stringValue IN %@", ["chill".localized])
        
        
        if (m_moodchill.count != 0 ){
            
            for index in 0...m_moodchill.count-1 {
                self.MoodsChill.append(m_moodchill[index].smallPhoto)
                self.IdChill.append(m_moodchill[index]._id)
                
            }
        }*/
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       /* RequestServer.sharedInstance.GetmoodUsers (_id: User.sharedInstance.get_id(), _mood: mymoodMoodActivate, whiteList: UserManager.sharedInstance.getWhiteList()) { (json) in
   
            print(json)
         
            var i = 1
         
            if (self.isPlusActive == false) {
            for index in 0...json["userList"].count-1 {
                
              //
                
                let dataItem = DataItem(indexes: String(myindex + i), colour: json["userList"][index]["mediumPhoto"].stringValue, type: "userprofil", age: json["userList"][index]["age"].stringValue, hashtag: json["userList"][index]["hashtag"].stringValue, descr: "", pseudo: json["userList"][index]["name"].stringValue, longitude: json["userList"][index]["position"]["longitude"].stringValue, latitude: json["userList"][index]["position"]["latitude"].stringValue)
                
                //items.append(dataItem)
                self.ProfilUsers[0].insert(dataItem, at: myindex + i)
                i = i + 1
          
                }
                
                UserManager.sharedInstance.setIndexActive(_indexActive: String(myindex))
                let indexseconde = sender.tag + 1
                self.secondCollectionView.scrollToItem(at: IndexPath(item: indexseconde, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                
          
            }
            else {
                for index in 0...json["userList"].count-1 {
                    
                    
                    print(json["userList"][index]["mediumPhoto"].stringValue)
                    let dataitem = DataItem(indexes: String(myindex + i), colour: json["userList"][index]["mediumPhoto"].stringValue, type: "userprofil", age: json["userList"][index]["age"].stringValue, hashtag: json["userList"][index]["hashtag"].stringValue, descr: "", pseudo: json["userList"][index]["name"].stringValue, longitude: json["userList"][index]["position"]["longitude"].stringValue, latitude: json["userList"][index]["position"]["latitude"].stringValue)
                    print(myindex + i)
                    //items.apProfilsListepend(dataItem)
                    //self.ProfilUsers[0].remove(at: myindex + i)
                   
                    if let index = self.ProfilUsers[0].index(of: dataitem) {
                        self.ProfilUsers[0].remove(at: index)
                    }
                    print(self.ProfilUsers[0])
                    i = i + 1
                    
                }
                UserManager.sharedInstance.setIndexActive(_indexActive: String(myindex))
                
            
            }*/
  
         /*   let realm = try! Realm()
            let listes = realm.objects(ProfilsListe.self)
            
            
            
            try! realm.write ({
                realm.delete(listes)
            })
            
            for itemliste in self.ProfilUsers[0]{
            
                let profilsItem = ProfilsListe()
                profilsItem.indexes = itemliste.indexes
                profilsItem.name = itemliste.colour
                profilsItem.type = itemliste.type
                
                try! realm.write {
                    realm.add(profilsItem)
                }
                
            }
            
            
            self.secondCollectionView.reloadData()*/
        let realm = try! Realm()
            
           var m_moodActive = realm.objects(WhiteList.self)
   
            if(mymoodMoodActivate == "soiree".localized && self.isPlusActiveSoiree == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["soiree".localized])
                print("soireetrue")
                self.isPlusActive = true
                self.isPlusActiveSoiree = true
            }
            else if(mymoodMoodActivate == "soiree".localized && self.isPlusActiveSoiree == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["soiree".localized])
                
                print("soireefalse")
                self.isPlusActive = false
                self.isPlusActiveSoiree = false
            }
            
            if(mymoodMoodActivate == "sport".localized && self.isPlusActiveSport == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["sport".localized])
                
                
                self.isPlusActive = true
                self.isPlusActiveSport = true
            }
            else if(mymoodMoodActivate == "sport".localized && self.isPlusActiveSport == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["sport".localized])
                
                self.isPlusActive = false
                self.isPlusActiveSport = false
            }
            
            if(mymoodMoodActivate == "food".localized && self.isPlusActiveFood == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["food".localized])
                self.isPlusActive = true
                self.isPlusActiveFood = true
            }
            else if(mymoodMoodActivate == "food".localized && self.isPlusActiveFood == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["food".localized])
                
                self.isPlusActive = false
                self.isPlusActiveFood = false
            }
            
            if(mymoodMoodActivate == "game".localized && self.isPlusActiveGame == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["game".localized])

                self.isPlusActive = true
                self.isPlusActiveGame = true
            }
            else if(mymoodMoodActivate == "game".localized && self.isPlusActiveGame == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["game".localized])

                self.isPlusActive = false
                self.isPlusActiveGame = false
            }
            
            if(mymoodMoodActivate == "autres".localized && self.isPlusActiveAutres == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["autres".localized])

                self.isPlusActive = true
                self.isPlusActiveAutres = true
            }
            else if(mymoodMoodActivate == "autres".localized && self.isPlusActiveAutres == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["autres".localized])

                self.isPlusActive = false
                self.isPlusActiveAutres = false
            }
            
            if(mymoodMoodActivate == "chill".localized && self.isPlusActiveChill == false)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["chill".localized])

                self.isPlusActive = true
                self.isPlusActiveChill = true
            }
            else if(mymoodMoodActivate == "chill".localized && self.isPlusActiveChill == true)
            {
                m_moodActive = m_moodActive.filter("ANY moodsV.stringValue IN %@", ["chill".localized])

                self.isPlusActive = false
                self.isPlusActiveChill = false
            }
       
        var i = 1
      
        //print(m_moodActive)
      
        
        
        //gestion des affichages
        
        if (self.isPlusActive == true) {
            
        
        
        if (m_moodActive.count != 0 ){
            
            for index in 0...m_moodActive.count-1 {
                
                  var MoodString = ""
                print(m_moodActive[index].hashtagsV)
                if(m_moodActive[index].hashtagsV.count != 0 ) {
                for indexhach in 0...m_moodActive[index].hashtagsV.count - 1{
                
                   
                    if (m_moodActive[index].hashtagsV[indexhach].moods == mymoodMoodActivate) {
                        MoodString = m_moodActive[index].hashtagsV[indexhach].stringHach
                        print(MoodString)
                        }
                    }
                }
                

                
                // self.MoodsSoiree.append(m_moodSoiree[index].smallPhoto)
                //self.IdSoiree.append(m_moodSoiree[index]._id)
               let dataItem = DataItem(indexes: String(myindex + i), colour: m_moodActive[index].mediumPhoto, type: "userprofil", age: m_moodActive[index].age, hashtag: MoodString, descr: "", pseudo:m_moodActive[index].name, longitude: m_moodActive[index].longitude, latitude: m_moodActive[index].latitude)
               // print(dataItem.hashtag)
                //items.append(dataItem)
                self.ProfilUsers[0].insert(dataItem, at: myindex + i)
                i = i + 1
        
            }
            
            
            UserManager.sharedInstance.setIndexActive(_indexActive: String(myindex))
            let listes = realm.objects(ProfilsListe.self)
            
            try! realm.write ({
                realm.delete(listes)
            })
            
            for itemliste in self.ProfilUsers[0]{
                
                let profilsItem = ProfilsListe()
                profilsItem.indexes = itemliste.indexes
                profilsItem.name = itemliste.colour
                profilsItem.type = itemliste.type
                
                try! realm.write {
                    realm.add(profilsItem)
                }
                
            }
            
            self.secondCollectionView.reloadData()
            let indexseconde = sender.tag + 1
            print(indexseconde)
            self.secondCollectionView.scrollToItem(at: IndexPath(item: indexseconde, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            
            
            }
            
        }
        else {
            
        if (m_moodActive.count != 0 ){
            
        for index in 0...m_moodActive.count-1 {
            var MoodString = ""
            
            if(m_moodActive[index].hashtagsV.count != 0 ) {
                for indexhach in 0...m_moodActive[index].hashtagsV.count - 1{
                    
                    print(m_moodActive[index].hashtagsV[indexhach].moods)
                    
                    if (m_moodActive[index].hashtagsV[indexhach].moods == mymoodMoodActivate) {
                        
                        MoodString = m_moodActive[index].hashtagsV[indexhach].stringHach
                        
                    }
                }
            }
            
          
            // self.MoodsSoiree.append(m_moodSoiree[index].smallPhoto)
            //self.IdSoiree.append(m_moodSoiree[index]._id)
            let dataItem = DataItem(indexes: String(myindex + i), colour: m_moodActive[index].mediumPhoto, type: "userprofil", age: m_moodActive[index].age, hashtag: MoodString, descr: "", pseudo:m_moodActive[index].name, longitude: m_moodActive[index].longitude, latitude: m_moodActive[index].latitude)
            
            print(dataItem)
            if let index = self.ProfilUsers[0].index(of: dataItem) {
                self.ProfilUsers[0].remove(at: index)
            }
        
          i = i + 1
            
            UserManager.sharedInstance.setIndexActive(_indexActive: String(myindex))
            let listes = realm.objects(ProfilsListe.self)
            
            try! realm.write ({
                realm.delete(listes)
            })
            
            for itemliste in self.ProfilUsers[0]{
                
                let profilsItem = ProfilsListe()
                profilsItem.indexes = itemliste.indexes
                profilsItem.name = itemliste.colour
                profilsItem.type = itemliste.type
                
                try! realm.write {
                    realm.add(profilsItem)
                }
                
            }
            
            self.secondCollectionView.reloadData()
                }
            
            }
        }
        
        print(ProfilUsers)

        
    }



  /*  func removeOnce(itemToRemove: Int, fromArray:[String]) -> [String]{
        var resultArray = fromArray
        
        return resultArray
    }*/
    
    // MARK: collectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Go to profile view
        if collectionView == self.firstCollectionView {
            let storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let profileViewController : ProfileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            profileViewController.isMyProfile = true //Set the instance view to MyProfile
            self.present(profileViewController, animated: true)
        }
    }
    
    
    
    // MARK : UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numberOfItemsInSection\(ProfilUsers[collectionView.tag].count)")
        
        if collectionView == self.firstCollectionView {
            return UserPicure[collectionView.tag].count
            
        }else{
            return ProfilUsers[collectionView.tag].count
        }
        
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.firstCollectionView {
            
            let cellTop: ColorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ColorCell
            
             cellTop.initView(canvas: self.view, collectionViews: firstCollectionView, firstcollection: self.secondCollectionView, viewseconde: ViewFirst)
             
             if (UserPicure[0].count != 0 && UserPicure[0].count != 2){
             
                let dataItem = UserPicure[0][0]
             
                let photoName = dataItem.colour
                //let avatarImg = UIImage(named: photoName)
                cellTop.getImgProfil(_imgView: photoName)
            
             
                cellTop.layoutIfNeeded()
                return cellTop
             
             }else {
                return cellTop
             }
            
        }else {
            
            
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProfilCell
            cellB.initView(canvas: self.view, collectionViews: self.secondCollectionView, firstcollection: self.firstCollectionView)
            
            let realm = try! Realm()
            //  let profilliste = realm.objects(ProfilsListe.self)
            let idsoiree = realm.objects(ProfilsListe.self).filter("name == %@", "SOIREE").first?.indexes
            let idsport = realm.objects(ProfilsListe.self).filter("name == %@", "SPORT").first?.indexes
            let idfood = realm.objects(ProfilsListe.self).filter("name == %@", "FOOD").first?.indexes
            let idgame = realm.objects(ProfilsListe.self).filter("name == %@", "GAME").first?.indexes
            let idother = realm.objects(ProfilsListe.self).filter("name == %@", "OTHER").first?.indexes
            let idchill = realm.objects(ProfilsListe.self).filter("name == %@", "CHILL").first?.indexes
            
            let mystringint = UserManager.sharedInstance.getIndexActive()
            
            if(mystringint ==  idsoiree){
                ViewSeconde.backgroundColor = UIColor(red:0.58, green:0.15, blue:0.85, alpha:1.0)
                
            }
            if(UserManager.sharedInstance.getIndexActive() == idsport){
                ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.24, blue:0.42, alpha:1.0)
            }
            if(UserManager.sharedInstance.getIndexActive() == idfood){
                ViewSeconde.backgroundColor = UIColor(red:0.06, green:0.93, blue:0.82, alpha:1.0)
            }
            if(UserManager.sharedInstance.getIndexActive() == idgame){
                ViewSeconde.backgroundColor = UIColor(red:0.26, green:0.29, blue:0.98, alpha:1.0)
            }
            if(UserManager.sharedInstance.getIndexActive() == idother){
                ViewSeconde.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.11, alpha:1.0)
            }
            if(UserManager.sharedInstance.getIndexActive() == idchill){
                ViewSeconde.backgroundColor = UIColor(red:0.44, green:0.80, blue:0.99, alpha:1.0)
            }
            
            
            cellB.Btnitemsselect.addTarget(self, action: #selector(self.imageButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            cellB.Btnitemsselect.tag = indexPath.row
            let dataItem = ProfilUsers[collectionView.tag][indexPath.item]
            let photoName = dataItem.colour
            //var indexpathsoirée : Int = 0
            
            var image1 = UIImage()
            if ( dataItem.type == "userprofil") {
                
                image1 = UIImage(named: "jj")!
                
                
            }else {
                
                image1 = UIImage(named: photoName)!
                
            }
            print(dataItem.type)
            
            
            
            if ( photoName == "soiree".localized) {
                
                let image1 = UIImage(named: photoName)
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
                cellB.SetImgsBulles(_img: self.MoodsSoiree, type: dataItem.type)
                cellB.LblHachtag.text = "Soirée"
                
                
            }
            if ( photoName == "sport".localized) {
                
                
                let image1 = UIImage(named: photoName)
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
                cellB.SetImgsBulles(_img: self.MoodsSport, type: dataItem.type)
                cellB.LblHachtag.text = "Sport"
                
            }
            if ( photoName == "food".localized) {
                
                // secondCollectionView.backgroundColor = UIColor(red:0.00, green:0.93, blue:0.82, alpha:1.0)
                //Viewback.backgroundColor = UIColor(red:0.00, green:0.93, blue:0.82, alpha:1.0)
                
                let image1 = UIImage(named: photoName)
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
                cellB.SetImgsBulles(_img: self.MoodsFood, type: dataItem.type)
                cellB.LblHachtag.text = "Food"
                
            }
            if ( photoName == "game".localized) {
                let image1 = UIImage(named: photoName)
                
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                cellB.SetImgsBulles(_img: self.MoodsGame, type: dataItem.type)
                cellB.LblHachtag.text = "Game"
                
            }
            if ( photoName == "autres".localized) {
                
            
                let image1 = UIImage(named: photoName)
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
                cellB.SetImgsBulles(_img: self.MoodsAutre, type: dataItem.type)
                cellB.LblHachtag.text = "Autre"
                
            }
            if ( photoName == "chill".localized) {
                
                let image1 = UIImage(named: photoName)
                cellB.getImgProfil(_imgView: image1!, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
                cellB.SetImgsBulles(_img: self.MoodsChill, type: dataItem.type)
                cellB.LblHachtag.text = "Chill"
                
            }
                
            else {
                
                
                cellB.getImgProfil(_imgView: image1, dataitem: dataItem, photoname: photoName, type: dataItem.type, view: secondCollectionView, viewback: ViewSeconde)
                
                
            }
            
            
            cellB.isHidden = false
            if let kdCollectionView = collectionView as? KDDragAndDropCollectionView {
                
                if let draggingPathOfCellBeingDragged = kdCollectionView.draggingPathOfCellBeingDragged {
                    
                    if draggingPathOfCellBeingDragged.item == indexPath.item {
                        
                        cellB.isHidden = true
                    }
                }
            }
            
            return cellB
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // print("fdsqfdsq")
        
        
    }
    

    
    // MARK : KDDragAndDropCollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, dataItemForIndexPath indexPath: IndexPath) -> AnyObject {
       
        if collectionView == self.firstCollectionView {
    
            return UserPicure[collectionView.tag][indexPath.item]
            
        }else{
            
            return ProfilUsers[collectionView.tag][indexPath.item]
            
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: IndexPath) -> Void {
        
        if collectionView == self.firstCollectionView {
           
            //let cellA = collectionView.dequeueReusableCellWithReuseIdentifier("Cell") as! ColorCell
            if let di = dataItem as? DataItem {
                UserPicure[collectionView.tag].insert(di, at: indexPath.item)
                
            }
        }else{
            
        
            if let di = dataItem as? DataItem {
                ProfilUsers[collectionView.tag].insert(di, at: indexPath.item)
            }
        }
        
   
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath : IndexPath) -> Void {
       
       if collectionView == self.firstCollectionView {
        
            if ( UserPicure[collectionView.tag].count != 0) {
               UserPicure[collectionView.tag].remove(at: indexPath.item)
                //print(ProfilUsers[collectionView.tag][currentCell].colour)
                //self.swipProfilMood()
              // self.swipProfilMood()
            }
        }
        else{
    
        
            if ( ProfilUsers[collectionView.tag].count != 0) {
                ProfilUsers[collectionView.tag].remove(at: indexPath.item)
                //print(currentCell)
               // self.tap()
              /*  let realm = try! Realm()
                let realm = try! Realm()
                let profildelete = realm.objects(ProfilsListe).filter("indexes = \()")
                
                try! realm.write {
                    realm.add(profilsItem)
                }*/
                let realm = try! Realm()
                let listes = realm.objects(ProfilsListe.self)
                
                
                
                try! realm.write ({
                    realm.delete(listes)
                })
                
                for itemliste in ProfilUsers[0]{
                    
                    let profilsItem = ProfilsListe()
                    profilsItem.indexes = itemliste.indexes
                    profilsItem.name = itemliste.colour
                    profilsItem.type = itemliste.type
                
                    try! realm.write {
                        realm.add(profilsItem)
                    }
                
                }
                
               
                
                
        }
        
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, moveDataItemFromIndexPath from: IndexPath, toIndexPath to : IndexPath) -> Void {
    
    }
    
 
    

    
    func collectionView(_ collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> IndexPath? {
  
        
        
        if collectionView == self.firstCollectionView {
            
            if let candidate : DataItem = dataItem as? DataItem {
                
                for item : DataItem in UserPicure[collectionView.tag] {
                    if candidate  == item {
                        if ( UserPicure[collectionView.tag].count != 0) {
                         let position = UserPicure[collectionView.tag].index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                            
                        }
                    }
                }
            }
            
            
        }else{
            if let candidate : DataItem = dataItem as? DataItem {
                
                for item : DataItem in ProfilUsers[collectionView.tag] {
                    if candidate  == item {
                        if ( ProfilUsers[collectionView.tag].count != 0) {
                            
                        let position = ProfilUsers[collectionView.tag].index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                            
                        }
                    }
                }
            }
        }
        
        
        return nil
        
    }
    
}



