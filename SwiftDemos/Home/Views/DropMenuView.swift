//
//  DropMenuView.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/5/16.
//

import Foundation
import UIKit

//private let SCREEN_WIDTH = UIScreen.main.bounds.size.width
//private let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class DropMenuView: UIView {

    public struct Index {
        // 列
        var column: Int
        //行
        var row: Int
        //item
        var item: Int
        
        init(column: Int, row: Int, item: Int = -1) {
            self.column = column
            self.row = row
            self.item = item
        }
    }

    //MARK:- 数据源
    weak var dataSource: DropMenuViewDataSource? {
        didSet {
            if oldValue === dataSource {
                return
            }
            dataSourceDidSet(dataSource: dataSource!)
        }
    }

    weak var delegate: DropMenuViewDelegate?

    private lazy var leftTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH, height: 0))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DropViewTableCellID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var rightTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH, height: 0))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DropViewTableCellID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var backgroundView: UIView = {
        let bgView = UIView(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.alpha = 0
        return bgView
    }()

    // 菜单的原点坐标
    private var menuOrigin: CGPoint = CGPoint.zero
    // 菜单高度
    private var menuHeight: CGFloat = 0
    // tableView最大高度
    private var maxTableViewHeight: CGFloat = SCREEN_HEIGHT - 200
    // 当前选中的是哪一列
    private var selectedColumn: Int = -1
    // 每一列选中的row
    private var selectedRows = Array<Int>()
    // 列表是否正在展示
    private var isShow: Bool = false
    // 动画时长
    private var animationDuration: TimeInterval = 0.25
    // cell的高度
    private let cellHeight: CGFloat = 50
    // cell的标识
    private let DropViewTableCellID = "DropViewTableCellID"
    // titleButtons
    private var titleButtons = [UIButton]()
    // 背景颜色
    private var bgColor: UIColor = UIColor.orange
    // title字体颜色
    private var titleColor: UIColor =  UIColor.white
    // title 字体大小
    private var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    // 分割线颜色
    private var seperatorLineColor: UIColor = UIColor.lightGray

    init(menuOrigin: CGPoint, menuHeight: CGFloat) {
        self.menuOrigin = menuOrigin
        self.menuHeight = menuHeight
        
        super.init(frame: CGRect(x: menuOrigin.x, y: menuOrigin.y, width: SCREEN_WIDTH, height: menuHeight))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        backgroundView.addGestureRecognizer(tapGesture)
        
        backgroundColor = bgColor
        
    }

    @objc func tapToDismiss() {
        animationTableView(show: false)
        isShow = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func dataSourceDidSet(dataSource: DropMenuViewDataSource) {
        let columns = dataSource.numberOfColumns(in: self)
        createTitleButtons(columns: columns)
        
        selectedRows = Array<Int>(repeating: 0, count: columns)
    }

    private func createTitleButtons(columns: Int) {

        let btnW: CGFloat = SCREEN_WIDTH / CGFloat(columns)
        let btnH: CGFloat = self.menuHeight
        let btnY: CGFloat = 0
        var btnX: CGFloat = 0
        
        for i in 0..<columns {
            let btn = UIButton(type: .custom)
            btnX = CGFloat(i) * btnW
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            btn.setTitle(dataSource?.menu(self, titleForRowsInIndePath: Index(column: i, row: 0)), for: .normal)
            btn.setTitleColor(titleColor, for: .normal)
            btn.titleLabel?.font = titleFont
            btn.addTarget(self, action: #selector(titleBtnDidClick(btn:)), for: .touchUpInside)
            btn.tag = i + 1000
            addSubview(btn)
            titleButtons.append(btn)
            
            let seperatorLine = UIView(frame: CGRect(x: btn.frame.maxX, y: 0, width: 1, height: btnH))
            seperatorLine.backgroundColor = seperatorLineColor
            addSubview(seperatorLine)
        }
    }

    @objc func titleBtnDidClick(btn: UIButton) {
        let column = btn.tag - 1000
        
        guard let dataSource = dataSource else {
            return
        }
        
        if selectedColumn == column && isShow {
            // 收回列表
            animationTableView(show: false)
            isShow = false
            
        } else {
            selectedColumn = column
            leftTableView.reloadData()
            
            // 刷新右边tableView
            if dataSource.menu(self, numberOfItemsInRow: selectedRows[selectedColumn], inColumn: selectedColumn) > 0 {
                rightTableView.reloadData()
            }
            
            // 展开列表
            animationTableView(show: true)
            isShow = true
        }
    }

    //MARK:- 展示或者隐藏TableView
    func animationTableView(show: Bool) {
        var haveItems = false
        let rows = leftTableView.numberOfRows(inSection: 0)
        if let dataSource = dataSource {
            for i in 0..<rows {
                if dataSource.menu(self, numberOfItemsInRow: i, inColumn: selectedColumn) > 0 {
                    haveItems = true
                }
            }
        }
        
        let tableViewHeight = CGFloat(rows) * cellHeight > maxTableViewHeight ? maxTableViewHeight : CGFloat(rows) * cellHeight
        
        if show {
            superview?.addSubview(backgroundView)
            superview?.addSubview(self)
            
            if haveItems {
                leftTableView.frame = CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0)
                rightTableView.frame = CGRect(x: SCREEN_WIDTH * 0.5, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH * 0.5, height: 0)
                superview?.addSubview(leftTableView)
                superview?.addSubview(rightTableView)
            } else {
                rightTableView.removeFromSuperview()
                leftTableView.frame = CGRect(x: menuOrigin.x, y: menuOrigin.y + menuHeight, width: SCREEN_WIDTH, height: 0)
                
//                let btnW: CGFloat = SCREEN_WIDTH / CGFloat(titleButtons.count)
//                leftTableView.frame = CGRect(x: menuOrigin.x + btnW * CGFloat(selectedColumn), y: menuOrigin.y + menuHeight, width: btnW, height: 0)
                
                superview?.addSubview(leftTableView)
            }

            UIView.animate(withDuration: animationDuration) {
                self.backgroundView.alpha = 1.0
                self.leftTableView.frame.size.height = tableViewHeight
                if haveItems {
                    self.rightTableView.frame.size.height = tableViewHeight
                }
            }
        } else {
            UIView.animate(withDuration: animationDuration, animations: {
                self.backgroundView.alpha = 0
                self.leftTableView.frame.size.height = 0
                if haveItems {
                    self.rightTableView.frame.size.height = 0
                }
            }) { (_) in
                self.backgroundView.removeFromSuperview()
                self.leftTableView.removeFromSuperview()
                if haveItems {
                    self.rightTableView.removeFromSuperview()
                }
            }
        }
    }

}

extension DropMenuView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            if tableView == leftTableView {
                return dataSource.menu(self, numberOfRowsInColumn: selectedColumn)
            } else {
                return dataSource.menu(self, numberOfItemsInRow: selectedRows[selectedColumn], inColumn: selectedColumn)
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropViewTableCellID)
        
        if let dataSource = dataSource {
            if tableView == leftTableView {
                cell?.textLabel?.text = dataSource.menu(self, titleForRowsInIndePath: Index(column: selectedColumn, row: indexPath.row))
                
                // 选中上次选中的那行
                if selectedRows[selectedColumn] == indexPath.row {
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                }
                
            } else {
                cell?.textLabel?.text = dataSource.menu(self, titleForItemInIndexPath: Index(column: selectedColumn, row: selectedRows[selectedColumn], item: indexPath.row))
                
                //选中上次选中的行
                if cell?.textLabel?.text == titleButtons[selectedColumn].titleLabel?.text {
                    leftTableView.selectRow(at: IndexPath(row: selectedRows[selectedColumn], section: 0), animated: true, scrollPosition: .none)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                }
            }
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else {
            return
        }
        
        if tableView == leftTableView {
            selectedRows[selectedColumn] = indexPath.row
            
            let haveItems = dataSource.menu(self, numberOfItemsInRow: indexPath.row, inColumn: selectedColumn) > 0
            if haveItems {
                rightTableView.reloadData()
            } else {
                //收回列表
                animationTableView(show: false)
                isShow = false
                
                //更新title
                titleButtons[selectedColumn].setTitle(dataSource.menu(self, titleForRowsInIndePath: Index(column: selectedColumn, row: indexPath.row)), for: .normal)
            }
            delegate?.menu(self, didSelectRowAtIndexPath: Index(column: selectedColumn, row: indexPath.row))
        } else {
            
            //收回列表
            animationTableView(show: false)
            isShow = false
            
            let index = Index(column: selectedColumn, row: selectedRows[selectedColumn], item: indexPath.row)
            
            //更新title
            titleButtons[selectedColumn].setTitle(dataSource.menu(self, titleForItemInIndexPath: index), for: .normal)
            
            delegate?.menu(self, didSelectRowAtIndexPath: index)
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
