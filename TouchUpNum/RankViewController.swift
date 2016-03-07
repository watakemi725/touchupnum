//
//  RankViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/13.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RankViewController: UIViewController, GADBannerViewDelegate {
    
    // AdMob設定ここから
    let AdMobID = "ca-app-pub-1674810718316989/3785200958"
    let TEST_DEVICE_ID = "ac83f39cfb8fa51eff147abbfee9d361"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = false
    // AdMob設定ここまで
    
    //NSUserDefaultsのインスタンスを生成
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var fourTextView:UITextView!
    @IBOutlet var eightTextView:UITextView!
    
    var tokutenFour = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        fourTextView.text
        
        makeRanking(fourTextView, whichAikotoba: "SCOREFOUR")
        
        makeRanking(eightTextView, whichAikotoba: "SCOREEIGHT")
        
        fourTextView.selectable = true
        eightTextView.selectable = true

        
    }
    
    func makeRanking(whichTF:UITextView , whichAikotoba:String){
        
        tokutenFour = ""
        //空の配列を用意
        var scoreBox: [Double] = []
        
        //前回の保存内容があるかどうかを判定
//        if((defaults.objectForKey("SCOREFOUR")) != nil){
        if((defaults.objectForKey(whichAikotoba)) != nil){
        
            //objectsを配列として確定させ、前回の保存内容を格納
//            let objects = defaults.objectForKey("SCOREFOUR") as? NSMutableArray
            let objects = defaults.objectForKey(whichAikotoba) as? NSMutableArray
            
            //各名前を格納するための変数を宣言
            var eachScore:AnyObject
            
            //前回の保存内容が格納された配列の中身を一つずつ取り出す
            for eachScore in objects!{
                //配列に追加していく
                scoreBox.append(eachScore as! Double)
            }
            
            if scoreBox.count > 1 {
                for i in 0...(scoreBox.count)-1 {
                    //                    tokutenFour = tokutenFour + " \n\(i+1).\(scoreBox[i])点 "
                    tokutenFour = tokutenFour + (NSString(format: "%d. %.2fpoint\n",i+1,scoreBox[i] ) as String) as String
                }
            }else if scoreBox.count == 1{
                tokutenFour = NSString(format: "1. %.2fpoint\n",scoreBox[0]) as String
            }
            
            
        }else{
            //まだないねん
            tokutenFour = "NO SCORES \n PLAY THE GAME"
        }
        whichTF.text = tokutenFour
        
    }
    
    override func viewWillAppear(animated: Bool) {
        /*Admo設定 ここから*/
        
        var admobView: GADBannerView = GADBannerView()
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        
        admobView.frame.origin = CGPointMake(0, self.view.frame.size.height - admobView.frame.height)
        admobView.frame.size = CGSizeMake(self.view.frame.width, admobView.frame.height)
        admobView.adUnitID = AdMobID
        admobView.delegate = self
        admobView.rootViewController = self
        
        let admobRequest:GADRequest = GADRequest()
        
        if AdMobTest {
            if SimulatorTest {
                admobRequest.testDevices = [kGADSimulatorID]
            }
            else {
                admobRequest.testDevices = [TEST_DEVICE_ID]
            }
            
        }
        
        admobView.loadRequest(admobRequest)
        
        self.view.addSubview(admobView)
        
        /*Admo設定 ここまで*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topBack(){
        //        に度戻りを実現
        //        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        //        self.dismissViewControllerAnimated(true, completion: nil)
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
