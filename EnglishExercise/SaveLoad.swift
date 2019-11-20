//
//  SaveLoad.swift
//  EnglishExercise
//
//  Created by 張哲禎 on 2019/11/20.
//  Copyright © 2019 張哲禎. All rights reserved.
//

import Foundation

func saves(save:[[String]]){
    let data = try? JSONEncoder().encode(save)
    UserDefaults.standard.set(data,forKey: "saves")
    Swift.print("存取\(data!)")
}
func loads()->[[String]]{
    var recordArray = [[String]]()
    if let  data = UserDefaults.standard.data(forKey: "saves"){
        if let savesDefault = try? JSONDecoder().decode([[String]].self, from: data){
            recordArray = savesDefault
            Swift.print("讀取\(savesDefault)")
        }
    }
    return recordArray
}
