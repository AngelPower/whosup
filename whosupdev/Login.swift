//
//  ViewController.swift
//  whosupdev
//
//  Created by Sophie Romanet on 06/06/2017.
//  Copyright © 2017 Sophie Romanet. All rights reserved.
//

import UIKit
import AVFoundation
import FacebookCore
import FacebookLogin
import Alamofire
import SwiftyJSON
import FBSDKCoreKit
import FBSDKLoginKit

class Login: UIViewController, FBSDKLoginButtonDelegate {

    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    @IBOutlet var loginButton: FBSDKLoginButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.InitView()
        
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
    }
    
    
    //MARk: Init view
    
    func InitView() {
    
        //init button facebook
        loginButton.readPermissions = ["public_profile","email"]
        loginButton.delegate = self
        
        
        //init player
        if let audioFilePath = Bundle.main.path(forResource: "video", ofType: "mp4") {
            print(audioFilePath)
            avPlayer =  AVPlayer(url: URL(fileURLWithPath: audioFilePath))
            avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            avPlayer.volume = 0
            avPlayer.actionAtItemEnd = .none
            
            avPlayerLayer.frame = view.layer.bounds
            view.backgroundColor = .clear
            view.layer.insertSublayer(avPlayerLayer, at: 0)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: avPlayer.currentItem)
            avPlayer.seek(to: kCMTimeZero)
            avPlayer.play()
        }
    }
    
    
    
    // MARK: facebook connect
    func loginButton(_ fbLoginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil)
        {
           print(error)
        }else if result.isCancelled {
             print("Cancelled")
        }else {
            print("Logged In")
        
            facebookLogin()
        }
    }
    
    func loginButtonDidLogOut(_ fbLoginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    
    func facebookLogin() {
        
        let width = 500
        let height = 500
        
        if AccessToken.current != nil {
            let params = ["fields":"picture.width(\(width)).height(\(height)),email,name,gender,age_range"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start { (urlResponse, requestResult) in
                switch requestResult {
                case .failed(let error):
                    print(error)
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        let picture = responseDictionary["picture"] as! NSDictionary
                        let data = picture["data"] as! NSDictionary
                        let urlphoto = data["url"]
                        print(responseDictionary)
                        
                        User.sharedInstance.set_id(_id: "")
                        User.sharedInstance.setEmail(_email: responseDictionary["email"]! as! String)
                        User.sharedInstance.setFacebookid(_facebookid: responseDictionary["id"]! as! String)
                        User.sharedInstance.setGender(_gender:  responseDictionary["gender"]! as! String)
                        User.sharedInstance.setUrlphoto(_urlphoto: urlphoto as! String)
                        User.sharedInstance.setNom(_nom: responseDictionary["name"]! as! String)
                        User.sharedInstance.setTel(_tel: "")
                        
                        Alamofire.request(User.sharedInstance.getUrlphoto()).responseImage { response in
                            
                            if let image = response.result.value {
                                
                                // save photo facebook en local
                                let fileManager = FileManager.default
                                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("img_0")
                                //let image = UIImage(named: "apple.jpg")
                                
                                let imageData = UIImagePNGRepresentation(image)!
                                fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
                                                        let storyboard : UIStoryboard = UIStoryboard(name: "Inscription", bundle: nil)
                                let viewController : GeolocationAskViewController = storyboard.instantiateViewController(withIdentifier: "GeolocationAskViewController") as! GeolocationAskViewController
                                UserManager.sharedInstance.mainNavigationController.pushViewController(viewController, animated: true)
                                
                               
                            
                            }
                        }
              
                    }
                }
            }
            
        }
            else {
        }
    }
    
    
}

