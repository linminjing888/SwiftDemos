//
//  DropMenuViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/5/16.
//

import Foundation
import UIKit

class DropDownMenuViewController: MJBaseViewController {

    struct DropMenuData {
        static var TitleDatas = ["出售", "区域", "来源"]
        
        // 房屋类型
        static var HouseType = ["出租", "出售"]
        // 区域
        static var HouseArea = ["东城区": ["安定门", "交道口", "王府井", "和平里", "北新桥", "东直门外", "东直门", "雍和宫"], "西城区": ["新街口", "阜成门", "金融街", "长椿街", "西单"], "朝阳区": ["双井", "国贸", "北苑", "大望路", "四惠", "十里堡", "花家池"], "丰台区": ["方庄", "角门", "草桥", "木樨园", "宋家庄", "东大街", "南苑", "大红门"]]
        //来源
        static var HouseSource = ["全部来源", "房天下", "便民网", "列表网", "城际分类", "58同城", "赶集", "安居客"]
    }

    private var menuView: DropMenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "下拉菜单"
        
        view.backgroundColor = UIColor.white
        
        menuView = DropMenuView(menuOrigin: CGPoint(x: 0, y: 0), menuHeight: 50)
        menuView.dataSource = self
        menuView.delegate = self
        view.addSubview(menuView)
    }
    
}

extension DropDownMenuViewController: DropMenuViewDelegate {
    func menu(_ menu: DropMenuView, didSelectRowAtIndexPath index: DropMenuView.Index) {
        print(index.column, index.row, index.item)
    }
}

extension DropDownMenuViewController: DropMenuViewDataSource {
    func numberOfColumns(in menu: DropMenuView) -> Int {
        return DropMenuData.TitleDatas.count
    }

    func menu(_ menu: DropMenuView, numberOfRowsInColumn column: Int) -> Int {
        if column == 0 {
            return DropMenuData.HouseType.count
        } else if column == 1 {
            return DropMenuData.HouseArea.count
        } else if column == 2 {
            return DropMenuData.HouseSource.count
        }
        return 0
    }

    func menu(_ menu: DropMenuView, titleForRowsInIndePath index: DropMenuView.Index) -> String {
        switch index.column {
        case 0:
            return DropMenuData.TitleDatas[index.row]
        case 1:
            return Array(DropMenuData.HouseArea.keys)[index.row]
        case 2:
            return DropMenuData.HouseSource[index.row]
        default:
            return ""
        }
    }

    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int {
        if inColumn == 1 {
            return Array(DropMenuData.HouseArea.values)[row].count
        }
        return 0
    }

    func menu(_ menu: DropMenuView, titleForItemInIndexPath indexPath: DropMenuView.Index) -> String {
        if indexPath.column == 1 {
            return Array(DropMenuData.HouseArea.values)[indexPath.row][indexPath.item]
        }
        return ""
    }
}
