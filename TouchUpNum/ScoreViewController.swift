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
        
        
        scoreLabel.text = String(scoreNum)+"点"
        correctLabel.text = String(appDelegate.correctNum) + "個"
        missLabel.text = String(appDelegate.missNum) + "個"
        speedLabel.text = NSString(format: "%.2f タップ/秒", appDelegate.speedNum) as String
        comboLabel.text = String(appDelegate.comboNum) + "コンボ"
        maxComboLabel.text = "最大" + String(maxCombo) + "コンボ"
        
        let allScore = scoreNum + speedNum + Double(comboNum)
        OverAllLabel.text = NSString(format: "%.2f 点", allScore) as String
        
//        rankNum(allScore
        rankNum(allScore, switchPlay: appDelegate.switchPlay)
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
            var scoreBox: [Double] = []
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
