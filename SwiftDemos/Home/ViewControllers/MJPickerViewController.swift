//
//  MJPickerViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/5.
//

import UIKit

class MJPickerViewController: MJBaseViewController {

    var pickerView:UIPickerView!
    var emojiArr = ["😀","😎","😈","👻","🙈","🐶","🌚","🍎","🎾","🐥","🐔"]
    var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
    }
    
    func setupUI() {
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 220))
        pickerView.center.x = self.view.center.x
        pickerView.center.y = self.view.center.y - 50
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        
        pickerView.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 0, animated: false)
        pickerView.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 1, animated: false)
        pickerView.selectRow(Int(arc4random()) % (emojiArr.count - 1), inComponent: 2, animated: false)
        
        let slotBtn = UIButton(type: .roundedRect)
        slotBtn.backgroundColor = .orange
        slotBtn.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40)
        slotBtn.setTitle("Slot", for: .normal)
        slotBtn.setTitleColor(UIColor.white, for: .normal)
        slotBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        slotBtn.center.y = self.view.center.y + 140
        slotBtn.center.x = self.view.center.x
        slotBtn.addTarget(self, action: #selector(slotBtnClicked), for: .touchUpInside)
        self.view.addSubview(slotBtn)

        let doubleTapGes = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
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
        
        pickerView.selectRow(Int.random(in: 0...emojiArr.count - 1), inComponent: 0, animated: true)
        pickerView.selectRow(Int.random(in: 0...emojiArr.count - 1), inComponent: 1, animated: true)
        pickerView.selectRow(Int.random(in: 0...emojiArr.count - 1), inComponent: 2, animated: true)
        
        judge()
    }
    
    @objc func doubleTapAction() {
        let randomNum = Int.random(in: 0...emojiArr.count - 1)
        
        pickerView.selectRow(randomNum, inComponent: 0, animated: true)
        pickerView.selectRow(randomNum, inComponent: 1, animated: true)
        pickerView.selectRow(randomNum, inComponent: 2, animated: true)
        
        judge()
    }
    
    func judge() {
        if pickerView.selectedRow(inComponent: 0) == pickerView.selectedRow(inComponent: 1) && pickerView.selectedRow(inComponent: 1) == pickerView.selectedRow(inComponent: 2) {
            resultLabel.text = "👏👏👏"
        }else{
            resultLabel.text = "💔💔💔"
        }
    }

}

extension MJPickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArr.count
    }
    
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
