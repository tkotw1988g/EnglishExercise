//
//  recordLiastVC.swift
//  EnglishExercise
//
//  Created by 張哲禎 on 2019/11/20.
//  Copyright © 2019 張哲禎. All rights reserved.
//

import UIKit

class recordLiastVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tV: UITableView!
    var recordArray = [[String]]()
    var linesArray = [String]()
    var searchArray = [[String]]()
    var search = false
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArray = [[String]]()
        let text = searchBar.text ?? ""
        if text == "" {
            search = false
        }else {
            for i in 0..<recordArray.count{
                let linesArray = recordArray[i]
                let line = linesArray[0]
                let linePartArray = line.components(separatedBy: "\t")
                
                print("看\(text.lowercased())")
                print("核對\(linePartArray[0].lowercased())")
                
                if (linePartArray[0].lowercased().contains(text.lowercased())) {
                    searchArray.append(linesArray)
                }
            }
            search = true
        }
        tV.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    //        第一次按下得到回應後就退出
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search{
            return searchArray.count
        }else{
         return recordArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var adjustArray = [[String]]()
        if search{
            adjustArray = searchArray
        }else{
            adjustArray = recordArray
        }
        let cellId = "recordId"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)! as! RecordCell
        let lines = adjustArray[indexPath.row]
        let line  = lines[0]
        let linePart = line.components(separatedBy: "\t")
        cell.label.text = "單字：\(linePart[0])"
        cell.print.text  = "例句：\(linePart[2])"
        cell.print.textColor = UIColor.blue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        linesArray = recordArray[indexPath.row]
//        print(""linesArray)
//
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let lines = recordArray[indexPath.row]
        let line = lines[0]
        let linePartArray = line.components(separatedBy: "\t")
        let delete = UIContextualAction(style: .normal, title: "取消追蹤") { (action, view, bool) in
            let controller = UIAlertController(title: "確定取消該筆追蹤", message: linePartArray[0], preferredStyle: .alert)
            let ok = UIAlertAction(title: "是", style: .default) { (alert) in
                self.recordArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                saves(save: self.recordArray)
            }
            let cancel = UIAlertAction(title: "否", style: .cancel) { (alert) in
            }
            controller.addAction(ok)
            controller.addAction(cancel)
            self.present(controller,animated: true)
        }
        delete.backgroundColor = UIColor.red
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        recordArray = loads()
//        Swift.print(recordArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recordArray = loads()
        Swift.print(recordArray)
        tV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        linesArray = recordArray[tV.indexPathForSelectedRow!.row]
        let detailVC = segue.destination as! DetailVC
        print("傳過去的值\(linesArray)")
        detailVC.linesArray = linesArray
    }
}
