//
//  DetailVC.swift
//  EnglishExercise
//
//  Created by 張哲禎 on 2019/11/20.
//  Copyright © 2019 張哲禎. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var linesArray = [String]()
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var print1: UITextView!
    @IBOutlet weak var print2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let lineNoArray = linesArray[0]
        let lineArray = lineNoArray.components(separatedBy: "\t")
        label1.text = "單字：\(lineArray[0])"
        label2.text = "中文解釋：\(lineArray[1])"
        print1.text = "例句：\n\n\(lineArray[2])"
        print2.text = "中文解釋：\n\n\(lineArray[3])"
    }
}
