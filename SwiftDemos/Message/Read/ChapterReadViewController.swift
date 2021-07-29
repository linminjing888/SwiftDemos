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
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        tap.require(toFail: doubleTap)
        
        return scrollView
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.background
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(ReadCollectionViewCell.self, forCellWithReuseIdentifier: "readId")
        
        return collection
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
            collectionView.reloadData()
        }
    }
    
    private var detailStatic: DetailStaticModel?
    private var selectIndex: Int = 0
    private var chapterList = [ChapterModel]()
    
    convenience init(detailStatic: DetailStaticModel?, selectIndex: Int) {
        self.init()
        self.detailStatic = detailStatic
        self.selectIndex = selectIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
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
        
        backScrollView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.height.equalTo(backScrollView)
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
    
    private func loadData() {
        guard let detailStatic = detailStatic else { return }
        topBar.titleLbl.text = detailStatic.comic?.name
        
        guard let chapterId = detailStatic.chapter_list?[selectIndex].chapter_id else { return }
        ApiLoadingProvider.request(MJApi.chapter(chapter_id: chapterId), model: ChapterModel.self) { (returnData) in
            guard let chapter = returnData else { return }
            self.chapterList.append(chapter)
            self.collectionView.reloadData()
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
    
    @objc private func doubleTapAction() {
        var zoomScale = backScrollView.zoomScale
        print(zoomScale)
        zoomScale = 2.5 - zoomScale // 取反
        let width = view.frame.width / zoomScale
        let height = view.frame.height / zoomScale
        let zoomRect = CGRect(x: backScrollView.center.x - width / 2, y: backScrollView.center.y - height / 2, width: width, height: height)
        backScrollView.zoom(to: zoomRect, animated: true)
        
    }

}


extension ChapterReadViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isBarHidden == false {
            isBarHidden = true
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == backScrollView {
            return collectionView
        }else{
            return nil
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView == backScrollView {
            scrollView.contentSize = CGSize(width: scrollView.frame.width * scrollView.zoomScale, height: scrollView.frame.height * scrollView.zoomScale)
        }
    }
}

extension ChapterReadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return chapterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterList[section].image_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "readId", for: indexPath) as! ReadCollectionViewCell
        cell.model = chapterList[indexPath.section].image_list?[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let imageModel = chapterList[indexPath.section].image_list?[indexPath.row] else { return CGSize.zero }
        let width = backScrollView.frame.width
        let height = floor(width / CGFloat(imageModel.width) * CGFloat(imageModel.height))
        return CGSize(width: width, height: height)
    }
    
    
    
}
