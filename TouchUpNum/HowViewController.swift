//
//  HowViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/03/09.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HowViewController: UIViewController , GADBannerViewDelegate {
    
    
    // AdMob ID を入れてください
    let AdMobID = "ca-app-pub-1674810718316989/3785200958"
    let TEST_DEVICE_ID = "ac83f39cfb8fa51eff147abbfee9d361"
    let AdMobTest:Bool = true
    let SimulatorTest:Bool = false
    
    
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
    
    
    @IBAction func topBack(){
        //        に度戻りを実現
        self.dismissViewControllerAnimated(true, completion: nil)
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
