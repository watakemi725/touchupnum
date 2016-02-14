//
//  RankViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/13.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    //NSUserDefaultsのインスタンスを生成
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var fourTextField:UITextView!
    @IBOutlet var eightTextField:UITextView!
    
    var tokutenFour = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //空の配列を用意
        var scoreBox: [Double] = []
        
        //前回の保存内容があるかどうかを判定
        if((defaults.objectForKey("SCORE")) != nil){
            
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.objectForKey("SCORE") as? NSMutableArray
            
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
                     tokutenFour = tokutenFour + (NSString(format: "\n%d位 %.2f点",i+1,scoreBox[i] ) as String) as String
                }
            }else if scoreBox.count == 1{
                tokutenFour = " \n 1.\(scoreBox[0])点 "
            }

            
        }else{
            //まだないねん
            print("notyet")
        }
        fourTextField.text = tokutenFour
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
