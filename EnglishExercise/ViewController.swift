//
//  ViewController.swift
//  EnglishExercise
//
//  Created by 張哲禎 on 2019/11/19.
//  Copyright © 2019 張哲禎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var word:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick(_ sender: UIButton) {
        word = sender.currentTitle
        performSegue(withIdentifier: "toDicVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dicVC = segue.destination as! DicVC
        dicVC.word = word
    }
}

