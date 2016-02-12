//
//  ScoreViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/10.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //AppDelegateのインスタンスを取得

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
        
        
        scoreLabel.text = String(scoreNum)+"点"
        correctLabel.text = String(appDelegate.correctNum) + "個"
        missLabel.text = String(appDelegate.missNum) + "個"
        speedLabel.text = NSString(format: "%.2f タップ/秒", appDelegate.speedNum) as String
        comboLabel.text = String(appDelegate.comboNum) + "コンボ"
        maxComboLabel.text = "最大" + String(maxCombo) + "コンボ"
        
        let allScore = scoreNum + speedNum + Double(comboNum)
        OverAllLabel.text = NSString(format: "%.2f 点", allScore) as String
        
        
        
    }
    
    @IBAction func topBack(){
//        に度戻りを実現
    self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
//self.dismissViewControllerAnimated(true, completion: nil)
//        self.dismissViewControllerAnimated(true, completion: nil)
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
