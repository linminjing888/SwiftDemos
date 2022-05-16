//
//  DropMenuViewProtocol.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2022/5/16.
//

import Foundation

protocol DropMenuViewDelegate: NSObjectProtocol {
    func menu(_ menu: DropMenuView, didSelectRowAtIndexPath index: DropMenuView.Index)
}

protocol DropMenuViewDataSource: NSObjectProtocol {

    func numberOfColumns(in menu: DropMenuView) -> Int

    func menu(_ menu: DropMenuView, numberOfRowsInColumn column: Int) -> Int

    func menu(_ menu: DropMenuView, titleForRowsInIndePath index: DropMenuView.Index) -> String

    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int

    func menu(_ menu: DropMenuView, titleForItemInIndexPath indexPath: DropMenuView.Index) -> String
}

extension DropMenuViewDataSource {
    func numberOfColumns(in menu: DropMenuView) -> Int {
        return 1
    }

    func menu(_ menu: DropMenuView, numberOfItemsInRow row: Int, inColumn: Int) -> Int {
        return 0
    }

    func menu(_ menu: DropMenuView, titleForItemInIndexPath indexPath: DropMenuView.Index) -> String {
        return ""
    }
}
