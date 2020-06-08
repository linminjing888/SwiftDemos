//
//  ViewController.swift
//  EmojiSlotMachine
//
//  Created by MinJing_Lin on 2020/6/8.
//  Copyright © 2020 MinJing_Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var slotMachine : UIPickerView!
    var emojiArr = ["😀","😎","😈","👻","🙈","🐶","🌚","🍎","🎾","🐥","🐔"]
    var resultLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        slotMachine = UIPickerView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220))
        slotMachine.dataSource = self
        slotMachine.delegate = self
        slotMachine.center.x = self.view.center.x
        slotMachine.center.y = self.view.center.y - 50
        self.view.addSubview(slotMachine)
        
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 0, animated: false)
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 1, animated: false)
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 2, animated: false)
        
        let slotBtn = UIButton(type: .roundedRect)
        slotBtn.backgroundColor = UIColor.green
        slotBtn.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)
        slotBtn.setTitle("Slot", for: .normal)
        slotBtn.setTitleColor(UIColor.white, for: .normal)
        slotBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        slotBtn.center.y = self.view.center.y + 140
        slotBtn.center.x = self.view.center.x
        slotBtn.addTarget(self, action: #selector(slotBtnClicked), for: UIControl.Event.touchUpInside)
        self.view.addSubview(slotBtn)
        
        let doubleTapGes = UITapGestureRecognizer(target: self, action: #selector(doubleTapClicked))
        doubleTapGes.numberOfTapsRequired = 2
        slotBtn.addGestureRecognizer(doubleTapGes)
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 30)
        resultLabel.text = ""
        resultLabel.textColor = UIColor.darkGray
        resultLabel.center.x = self.view.center.x
        resultLabel.center.y = slotBtn.center.y + 100
        self.view.addSubview(resultLabel)
        
    }
    
    
    @objc func slotBtnClicked() {
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 0, animated: true)
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 1, animated: true)
        slotMachine.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 2, animated: true)
        
        self.judge()
    }
    
    @objc func doubleTapClicked() {
        
        let result = Int(arc4random()) % (emojiArr.count - 1)
        
        slotMachine.selectRow(result, inComponent: 0, animated: true)
        slotMachine.selectRow(result, inComponent: 1, animated: true)
        slotMachine.selectRow(result, inComponent: 2, animated: true)
        
        self.judge()
    }
    
    
    func judge() {
        if slotMachine.selectedRow(inComponent: 0) == slotMachine.selectedRow(inComponent: 1) && slotMachine.selectedRow(inComponent: 1) == slotMachine.selectedRow(inComponent: 2) {
            resultLabel.text = "👏👏👏"
        }else{
            resultLabel.text = "💔💔💔"
        }
    }


}

extension ViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        emojiArr.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return emojiArr[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickLbl = UILabel()
        pickLbl.text = emojiArr[row]
        pickLbl.textAlignment = .center
        pickLbl.font = UIFont.systemFont(ofSize: 60)
        return pickLbl
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }
    
    
}

