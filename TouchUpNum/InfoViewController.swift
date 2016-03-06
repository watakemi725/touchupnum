//
//  InfoViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/10.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit
/*
設定画面てきあ要素
*/


class InfoViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearRank(){
        
        //ランキングデータをすべて全削除
        NSUserDefaults.standardUserDefaults().removeObjectForKey("SCOREFOUR")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("SCOREEIGHT")
        
    }
    
    @IBAction func changeStartTime(){
        var alert = UIAlertController(title: "yo", message: "go", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Done", style: .Default){(action :UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            //ひょうじ
            print(textField.text)
            
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
