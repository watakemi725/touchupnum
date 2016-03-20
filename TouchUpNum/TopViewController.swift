//
//  TopViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/10.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TopViewController: UIViewController, GADBannerViewDelegate {

            
    
    //Admob設定
    
    // AdMob ID を入れてください
    let AdMobID = "ca-app-pub-1674810718316989/3785200958"
    let TEST_DEVICE_ID = "ac83f39cfb8fa51eff147abbfee9d361"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = false
    
//    @IBOutlet weak var admobView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        

//        // Do any additional setup after loading the view.
//        
//        let bannerView:GADBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
//        bannerView.adUnitID = "ca-app-pub-1674810718316989"
//        bannerView.delegate = self
//        bannerView.rootViewController = self
//        let gadRequest:GADRequest = GADRequest()
//        gadRequest.testDevices = [kGADSimulatorID]  // テスト時のみ
//        bannerView.loadRequest(gadRequest)
//        self.view.addSubview(bannerView)
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
