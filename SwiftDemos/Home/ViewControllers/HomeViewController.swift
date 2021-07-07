//
//  ViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/2.
//

import UIKit

class HomeViewController: MJBaseViewController {

    var tableView: UITableView!
    var dataArray: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.title = "首页"
        
        dataArray = ["Font","Weacher","TextView","Audio","Stretchy","Picker"]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
    }

}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "reusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        let text = dataArray[indexPath.row]
        cell?.textLabel?.text = "\(indexPath.row) - \(text)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = MJFontViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = MJWeatherViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = MJTextInputViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = MJAudioViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }  else if indexPath.row == 4 {
            let vc = MJStretchyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }  else if indexPath.row == 5 {
            let vc = MJPickerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

