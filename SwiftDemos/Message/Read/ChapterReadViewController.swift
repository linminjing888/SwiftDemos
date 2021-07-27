//
//  ChapterReadViewController.swift
//  SwiftDemos
//
//  Created by minjing.lin on 2021/7/27.
//

import UIKit

class ChapterReadViewController: MJBaseViewController {

    private var isBarHidden: Bool = false {
        didSet{
            UIView.animate(withDuration: 0.5) {
                self.topBar.snp.updateConstraints { (make) in
                    make.top.equalTo(self.backScrollView).offset(self.isBarHidden ? -(self.edgeInsets.top + 44) : 0)
                }
                self.bottomBar.snp.updateConstraints { (make) in
                    make.bottom.equalTo(self.backScrollView).offset(self.isBarHidden ? (self.edgeInsets.bottom + 120) : 0)
                }
            }
        }
    }
    
    var edgeInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        }else{
            return .zero
        }
    }
    
    lazy var backScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tap)
        
        return scrollView
    }()
    
    lazy var topBar: ReadTopBarView = {
        let topBar = ReadTopBarView()
        topBar.backgroundColor = UIColor.white
        topBar.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return topBar
    }()
    
    lazy var bottomBar: ReadBottomBarView = {
        let bottomBar = ReadBottomBarView()
        bottomBar.backgroundColor = UIColor.white
        bottomBar.deviceButton.addTarget(self, action: #selector(deviceAction(_: )), for: .touchUpInside)
        return bottomBar
    }()
    
    private var isLandscapeRight: Bool! {
        didSet {
            UIApplication.changeOrientationTo(landscapeRight: isLandscapeRight)
        }
    }
    
    private var detailStatic: DetailStaticModel?
    private var selectIndex: Int = 0
    
    convenience init(detailStatic: DetailStaticModel?, selectIndex: Int) {
        self.init()
        self.detailStatic = detailStatic
        self.selectIndex = selectIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isLandscapeRight = false
        navigationController?.barStyle(.white)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupUI() {
        
        view.addSubview(backScrollView)
        backScrollView.backgroundColor = .gray
        backScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.usnp.edges)
        }
        
        view.addSubview(topBar)
        topBar.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(backScrollView)
            make.height.equalTo(44)
        }
        
        view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(backScrollView)
            make.height.equalTo(120)
        }
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deviceAction(_ button: UIButton) {
        isLandscapeRight = !isLandscapeRight
        if isLandscapeRight {
            button.setImage(UIImage(named: "readerMenu_changeScreen_vertical")?.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            button.setImage(UIImage(named: "readerMenu_changeScreen_horizontal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @objc private func tapAction() {
        isBarHidden = !isBarHidden
    }

}


extension ChapterReadViewController: UIScrollViewDelegate {
    
}
