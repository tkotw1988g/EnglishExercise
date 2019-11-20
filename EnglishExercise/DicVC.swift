//
//  DicVC.swift
//  EnglishExercise
//
//  Created by 張哲禎 on 2019/11/19.
//  Copyright © 2019 張哲禎. All rights reserved.
//

import UIKit

class DicVC: UIViewController {
    var word:String?
    var lineArray:[String]?
    var linePartArray:[String]?
    var selectIndex = 0
    var isRecord = false
    var recordArray = [[String]]()
    //    放字串array的array
    @IBOutlet weak var btRecord: UIButton!
    @IBOutlet weak var print: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "alphabet:\(word!)"
        let path = Bundle.main.path(forResource: word!, ofType: "txt")
        //        let url = URL(string: urlStr!)
        //        專案內的文字檔案,建立後不要生成URL! 而是要用編碼解碼的方式去讀取
        
        //        分辨不出是utf8還16,那就做判斷式處理
        if let content = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8){
            Swift.print("utf8")
            lineArray = content.components(separatedBy: "\n")
        } else {
            let content = try? String(contentsOfFile: path!, encoding: String.Encoding.utf16)
            Swift.print("utf16")
            lineArray = content?.components(separatedBy: "\n")
            //            一行一行切,切完後每行存進lineArray
        }
        recordArray = loads()
        show()
//        Swift.print(loads())
//        Swift.print(recordArray)
    }
    @IBAction func btChinese(_ sender: Any) {
        let text1 = "單字：\(linePartArray![0])\t中文解釋：\(linePartArray![1])"
        let text2 = "例句：\(linePartArray![2])\n\n中文解釋：\(linePartArray![3])"
        label.text = text1
        print.text = text2
        imageView.image = UIImage(named: "bg3")
    }
    @IBAction func btRecord(_ sender: UIButton) {
        isRecord = false
        var recordNumber : Int?
        for i in 0..<recordArray.count{
            let lines = recordArray[i]
            let line  = lines[0]
            let linePart = line.components(separatedBy: "\t")
            if label.text! == linePart[0] {
                recordNumber = i
                isRecord = true
                Swift.print(label.text!)
                Swift.print(linePart[0])
                break
            }
        }
        Swift.print(label.text!)
        Swift.print(isRecord)
        if isRecord{
            Swift.print("變黑")
            recordArray.remove(at: recordNumber!)
            isRecord = false
            sender.setImage(UIImage(named: "blackHeart"), for: .normal)
        }else {
            Swift.print("變紅")
            recordArray.append([lineArray![selectIndex]])
            isRecord = true
            sender.setImage(UIImage(named: "redHeart"), for: .normal)
        }
        Swift.print(isRecord)
        saves(save: recordArray)
    }
    @IBAction func btNaxt(_ sender: UIButton) {
        selectIndex += 1
        if selectIndex == lineArray!.count{
            selectIndex = 0
        }
        imageView.image = UIImage(named: "bg2")
        show()
        redOrBlack(sender: btRecord)
    }
    @IBAction func btPrev(_ sender: UIButton) {
        selectIndex -= 1
        if selectIndex < 0 {
            selectIndex = lineArray!.count - 1
        }
        imageView.image = UIImage(named: "bg2")
        show()
        redOrBlack(sender: btRecord)
    }
    func show(){
        let line = lineArray![selectIndex]
        linePartArray = line.components(separatedBy: "\t")
        label.text = "單字：\(linePartArray![0])"
        print.text = "例句：\(linePartArray![2])"
    }
    func redOrBlack(sender: UIButton){
        sender.setImage(UIImage(named: "blackHeart"), for: .normal)
        isRecord = false
        Swift.print(recordArray.count)
        for i in 0..<recordArray.count{
            let lines = recordArray[i]
            let line  = lines[0]
            let linePart = line.components(separatedBy: "\t")
            if label.text == linePart[0] {
                isRecord = true
                sender.setImage(UIImage(named: "redHeart"), for: .normal)
                break
            }
        }
    }
}
