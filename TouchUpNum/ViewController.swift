//
//  ViewController.swift
//  TouchUpNum
//
//  Created by Takemi Watanuki on 2016/02/08.
//  Copyright © 2016年 Takemi Watanuki. All rights reserved.
//

import UIKit

let DetailSegueName = "scorePage"

//シャッフル
extension Array {
    mutating func shuffle(count: Int) {
        for _ in 0..<count {
            self.sortInPlace { _,_ in arc4random() < arc4random() }
        }
    }
}
class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var comboLabel: UILabel!
    @IBOutlet var adviceLabel: UILabel!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    var btnBox:[UIButton] = []
    var btnBoxNew:[UIButton] = []
    var numBox:[Int] = []
    var scoreBox:[Int] = []
    var comboBox:[Int] = []
    
    
    var tapNum = 0
    var downTime = 6.0
    var firstTime = 0.0
    var scoreNum = 0.0
    var ruleNum = 0
    var comboNum = 0
    var speedNum = 0.0
    var correctNum = 0
    var missNum = 0
    
    
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //AppDelegateのインスタンスを取得_
    
    
    var timer = NSTimer()
    
    override func viewDidAppear(animated: Bool) {
        tapNum = 0
        downTime = 6.0
        firstTime = downTime
        scoreNum = 0.0
        ruleNum = 0
        comboNum = 0
        speedNum = 0.0
        correctNum = 0
        missNum = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //数字をランダムに表示させるためにボタンをランダムに入れる
        btnBox = [btn1,btn2,btn3,btn4]
        numBox = [1,2,3,0]
        
        let image = UIImage(named: "a0.png")! as UIImage
        self.startBtn.setImage(image, forState: .Normal)
        
        //        firstTime = downTime
        
        setNum()
        //        for num in 0...btnBox.count-1 {
        //            btnBox[num].setTitle(String(numBox[num]), forState: .Normal)
        //            btnBox[num].setTitleColor(UIColor.whiteColor(), forState: .Normal)
        //            btnBox[num].titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(50))
        //
        //        }
    }
    
    @IBAction func startBtnAction(){
        
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            print("3")
            let image = UIImage(named: "a3.png")! as UIImage
            self.startBtn.setImage(image, forState: .Normal)
            
            
        })
        let delay2 = 1.5 * Double(NSEC_PER_SEC)
        let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay2))
        dispatch_after(time2, dispatch_get_main_queue(), {
            print("2")
            let image = UIImage(named: "a2.png")! as UIImage
            self.startBtn.setImage(image, forState: .Normal)
            
        })
        let delay3 = 2.5 * Double(NSEC_PER_SEC)
        let time3 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay3))
        dispatch_after(time3, dispatch_get_main_queue(), {
            print("1")
            let image = UIImage(named: "a1.png")! as UIImage
            self.startBtn.setImage(image, forState: .Normal)
            
        })
        let delay4 = 3.5 * Double(NSEC_PER_SEC)
        let time4 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay4))
        dispatch_after(time4, dispatch_get_main_queue(), {
            self.startBtn.hidden = true
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "eachSecond:", userInfo: nil, repeats: true)
        })
        
        
        
        
        
    }
    
    func eachSecond(timer: NSTimer) {
        
        if downTime > 0.01{
            downTime = downTime - 0.01
        }else{
            //切り上げ
            startBtn.hidden = false
            timer.invalidate()
            CalcAll()
            performSegueWithIdentifier(DetailSegueName, sender: nil)
        }
        timeLabel.text = NSString(format: "%.2f sec", downTime) as String
    }
    
    @IBAction func btnHantei(sender: UIButton){
        
        
        //判定を行う(まず1を探す)
        if sender.tag == ruleNum {
            //        if sender.tag == btnBox[sender.tag].tag{
            //        if sender.tag == btnBoxNew[ruleNum].tag{
            print(sender.tag)
            print("上タグ 下基準")
            print("rulenum=",ruleNum)
            print(btnBoxNew[sender.tag].tag)
            
            //何も表示させない
            btnBoxNew[sender.tag].setTitle("", forState: .Normal)
//            btnBoxNew[sender.tag].hidden = true

            
            
            //加点
            scoreShow(+1.0)
            correctNum++
            scoreBox.append(1)
            
            //数字がまだ存在するか確認する
            if ruleNum < 3{
                ruleNum++
            }else if ruleNum == 3{
                //numBoxにもっかい数字を追加してあげる
                setNum()
                ruleNum = 0
            }
            
            adviceLabel.text = "Nice!!"
            
        }else{
            //間違えた時
            //何もしないか、マイナスポイント
            print("まちがえた")
            scoreShow(-1.0)
            missNum++
            scoreBox.append(0)
                        adviceLabel.text = "Bad!!"
        }
        tapNum++
        
        comboCalc()
    }
    
    func scoreShow(score:Double){
        scoreNum = score + scoreNum
        scoreLabel.text = String(scoreNum)+"point"
    }
    
    //現状のコンボを表示するように
    func comboCalc(){
        var combo = 0
        for num in 0...scoreBox.count-1 {
            if scoreBox[num] == 1{
                combo++
                
            }else{
                combo = 0
            }
        }
        if combo>0{
            comboBox.append(combo)
        }
        comboLabel.text = String(combo) + "combo"
    }
    
    func setNum(){
        //数字をシャッフル
        numBox.shuffle(numBox.count)
        
        btnBoxNew.removeAll()
        
        for num in 0...btnBox.count-1 {
            btnBoxNew.append(btnBox[numBox[num]])
            print(numBox[num])
        }
        
        
        for num in 0...btnBox.count-1 {
            btnBoxNew[num].hidden = false
             btnBoxNew[num].tag = num
            let image = appDelegate.btnPic[num]
//            btnBoxNew[num].setImage(image, forState: .Normal)
            btnBoxNew[num].setTitle(String(num+1), forState: .Normal)
            btnBoxNew[num].setTitleColor(UIColor.whiteColor(), forState: .Normal)
//            btnBoxNew[num].titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(50))
            
        }
    }
    
    func makeMove(){
        //アニメーション実行部分
//        UIView.animateWithDuration(
//            duration,
//            //            options: UIViewAnimationOptions.Repeat,
//            animations: {
//                
//                shortView.transform = CGAffineTransformMakeRotation(( CGFloat(Angle1) * CGFloat(M_PI)) / 180.0)
//                longView.transform = CGAffineTransformMakeRotation(( CGFloat(Angle2) * CGFloat(M_PI)) / 180.0)
//            }, completion: { finished in
//                
//        })
    }
    
    func CalcAll(){
        
        appDelegate.scoreNumNow = scoreNum
        appDelegate.speedNum = Double(tapNum) / firstTime
        appDelegate.correctNum = correctNum
        appDelegate.missNum = missNum
        
        //通算のコンボ(連続点)を計算
        
        appDelegate.comboNum = comboBox.count
        if comboBox.count>0{
            appDelegate.maxComboNum = comboBox.maxElement()!
        }
        
        //保存するサイドの切り替え
        appDelegate.switchPlay = "SCOREFOUR"
    }
    
    //    func shuffle<T>(inout array: [T]) {
    //        for var j = array.count - 1; j > 0; j-- {
    //            var k = Int(arc4random_uniform(UInt32(j + 1))) // 0 <= k <= j
    //            swap(&array[k], &array[j])
    //        }
    //    }
    //
    //    func shuffled<S: SequenceType>(source: S) -> [S.Generator.Element] {
    //        var copy = Array<S.Generator.Element>(source)
    //        shuffle(&copy)
    //        return copy
    //    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

