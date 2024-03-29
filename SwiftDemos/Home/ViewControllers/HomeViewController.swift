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
        
        view.backgroundColor = .mainTextColor
        self.title = "首页"
        
        dataArray = ["Font","Weacher","TextView","Audio","Stretchy","Picker","Transition","ReverseValue","Swift特性","Closure","RxSwift","DropDownMenu","Codable","Prefix"]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .mainBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalToSuperview()
            }
        }
        
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
            let vc = WeatherViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = TextInputViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = AudioViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }  else if indexPath.row == 4 {
            let vc = StretchyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }  else if indexPath.row == 5 {
            let vc = PickerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = TransitionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = ReverseValueViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 8 {
            let vc = SwiftCharacterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 9 {
            let vc = ClosureLearnViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 10 {
//            let vc = RxSwiftViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
            let vc = RxSwiftViewController3()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 11 {
            let vc = DropDownMenuViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 12 {
            let vc = CodableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 13 {
            let vc = PrefixVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

