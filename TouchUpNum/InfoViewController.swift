//
//  InfoViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/10.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
import GoogleMobileAds
/*
設定画面てきあ要素
*/


class InfoViewController: UIViewController , GADBannerViewDelegate {
    
 
    
    
    //Admob設定
    
    // AdMob ID を入れてください
    let AdMobID = "ca-app-pub-1674810718316989/3785200958"
    let TEST_DEVICE_ID = "ac83f39cfb8fa51eff147abbfee9d361"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = false
    
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //AppDelegateのインスタンスを取得
    
    @IBOutlet var topnumBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var admobView: GADBannerView = GADBannerView()
        admobView = GADBannerView(adSize:kGADAdSizeBanner)
        
        admobView.frame.origin = CGPointMake(0, self.view.frame.size.height - admobView.frame.height)
        //        admobView.frame.origin = CGPointMake(0,200)
        
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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearRank(){
        
        
        
        
        // UIAlertController
        let alertController:UIAlertController = UIAlertController(title: "Alert", message: "Clear All Data?", preferredStyle: .Alert)
        
        // 選択肢
        // 異なる方法でactionを設定してみた
        let actionOK = UIAlertAction(title: "OK", style: .Default){
            action in
            //            self.labelSet("OK")
            //ランキングデータをすべて全削除
            NSUserDefaults.standardUserDefaults().removeObjectForKey("SCOREFOUR")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("SCOREEIGHT")
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .Cancel){
            (action) -> Void in
            //            self.label.text = "Cancel"
        }
        
        // actionを追加
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        // UIAlertの起動
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func changeStartTime(){
        var alert = UIAlertController(title: "Change Max Time", message: "Type in the Time", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Done", style: .Default){(action :UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            //ひょうじ
            print(textField.text)

            self.appDelegate.topNum = Double(textField.text!)!
            self.topnumBtn.setTitle("\(textField.text!) sec", forState: .Normal)
            
        }
        
        let cacelAction = UIAlertAction(title: "", style: .Default) { (action :UIAlertAction!) -> Void in
            
        }
        
        alert.addTextFieldWithConfigurationHandler { (textfield :UITextField!) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cacelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func whomadeIt(sender:UIButton){
        var url = NSURL(string: "")
        switch sender.tag {
        case 0:
            url = NSURL(string: "https://twitter.com/watakemi725")
            break
        case 1:
            url = NSURL(string: "https://github.com/watakemi725")
            break
        case 2:
            url = NSURL(string: "https://www.instagram.com/watakemi725/")
            break
        default:
            break
            
        }
        
        
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
        
    }
    
    @IBAction func topBack(){
        //        に度戻りを実現
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
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
