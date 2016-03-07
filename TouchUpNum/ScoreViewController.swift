//
//  ScoreViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/10.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Accounts

class ScoreViewController: UIViewController, GADBannerViewDelegate {
    
    // AdMob設定ここから
    let AdMobID = "ca-app-pub-1674810718316989/3785200958"
    let TEST_DEVICE_ID = "ac83f39cfb8fa51eff147abbfee9d361"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = false
    // AdMob設定ここまで
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //AppDelegateのインスタンスを取得
    
    //NSUserDefaultsのインスタンスを生成
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var scoreLabel:UILabel!
    @IBOutlet var comboLabel:UILabel!
    @IBOutlet var correctLabel:UILabel!
    @IBOutlet var missLabel:UILabel!
    @IBOutlet var speedLabel:UILabel!
    @IBOutlet var OverAllLabel:UILabel!
    @IBOutlet var maxComboLabel :UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let scoreNum = appDelegate.scoreNumNow
        let correctNum = appDelegate.correctNum
        let missNum = appDelegate.missNum
        let speedNum = appDelegate.speedNum
        let comboNum = appDelegate.comboNum
        let maxCombo = appDelegate.maxComboNum
        
        
        scoreLabel.text = String(scoreNum)+"point"
        correctLabel.text = String(appDelegate.correctNum) + "times"
        missLabel.text = String(appDelegate.missNum) + "times"
        speedLabel.text = NSString(format: "%.2f tap/sec", appDelegate.speedNum) as String
        comboLabel.text = String(appDelegate.comboNum) + "combo"
        maxComboLabel.text = "max" + String(maxCombo) + "combo"
        
        let allScore = scoreNum + speedNum + Double(comboNum)
        OverAllLabel.text = NSString(format: "%.2fpoints", allScore) as String
        
        //        rankNum(allScore
        rankNum(allScore, switchPlay: appDelegate.switchPlay)
        
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            
            /*Admo設定 ここから*/
            
            var admobView: GADBannerView = GADBannerView()
            admobView = GADBannerView(adSize:kGADAdSizeBanner)
            
            admobView.frame.origin = CGPointMake(0, self.view.frame.size.height - admobView.frame.height)
            admobView.frame.size = CGSizeMake(self.view.frame.width, admobView.frame.height)
            admobView.adUnitID = self.AdMobID
            admobView.delegate = self
            admobView.rootViewController = self
            
            let admobRequest:GADRequest = GADRequest()
            
            if self.AdMobTest {
                if self.SimulatorTest {
                    admobRequest.testDevices = [kGADSimulatorID]
                }
                else {
                    admobRequest.testDevices = [self.TEST_DEVICE_ID]
                }
                
            }
            
            admobView.loadRequest(admobRequest)
            
            self.view.addSubview(admobView)
            
            /*Admo設定 ここまで*/
            
        })
    }
    
    
    @IBAction func postBtn(){
        //sns投稿用
        
        let layer = UIApplication.sharedApplication().keyWindow?.layer;
        
        let scale = UIScreen.mainScreen().scale;
        UIGraphicsBeginImageContextWithOptions(layer!.frame.size, false, scale);
        
        layer!.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        // 共有する項目
        let shareText = "Played SPEED TAP"
        let shareWebsite = NSURL(string: "https://www.apple.com/jp/watch/")!
//        let shareImage = UIImage(named: "c1.png")!
        let shareImage = screenshot
        
        
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            
        
        let activityItems = [shareText, shareWebsite, shareImage]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypePrint,
            UIActivityTypeMessage,
            UIActivityTypeMail,
            UIActivityTypeCopyToPasteboard
            ,UIActivityTypeAssignToContact
            ,UIActivityTypeAddToReadingList
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.presentViewController(activityVC, animated: true, completion: nil)
        })
    
    }
    override func viewWillAppear(animated: Bool) {
        
    }
    
    @IBAction func topBack(){
        //        に度戻りを実現
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        //self.dismissViewControllerAnimated(true, completion: nil)
        //        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func playAgain(){
        //        に度戻りを実現
        //        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        //        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func rankNum(newScore:Double ,switchPlay:String){
        //もともと保存してるランキング配列を引っ張り出してくる
        
        //空の配列を用意
        var scoreBox: [Double] = []
        
        //前回の保存内容があるかどうかを判定
        if((defaults.objectForKey(switchPlay)) != nil){
            
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.objectForKey(switchPlay) as? NSMutableArray
            
            //各名前を格納するための変数を宣言
            var eachScore:AnyObject
            
            //前回の保存内容が格納された配列の中身を一つずつ取り出す
            for eachScore in objects!{
                //配列に追加していく
                scoreBox.append(eachScore as! Double)
            }
            
            
            scoreBox.append(newScore)
            
            
        }else{
            //前回保存した記録がない場合
            
            //空の配列を用意
            //            var scoreBox: [Double] = []
            scoreBox.append(newScore)
            
        }
        
        /*
        
        wakatimeを導入してみたけど結果が全然反映されない
        
        */
        //追加かつソートを行って保存
        
        
        
        
        scoreBox.sortInPlace{ $1 < $0 }
        
        //表示は別のところでいいkな
        print(scoreBox)
        
        //"NAME"というキーで配列namesを保存
        defaults.setObject(scoreBox, forKey:switchPlay)
        
        // シンクロを入れないとうまく動作しないときがあります
        defaults.synchronize()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
