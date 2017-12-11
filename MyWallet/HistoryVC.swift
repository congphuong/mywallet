//
//  HistoryVC.swift
//  MyWallet
//
//  Created by congphuong on 11/25/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class HistoryVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
    var histories: [History]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Lịch sử"
        
        let searchControler = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchControler
        //navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(HistoryCell.self, forCellWithReuseIdentifier: cellId)
        setupData()
        
        print(histories!.count as Any)
    }
    
    func setupData(){
        histories = []
        let h1 = History(id: "1",type: "Chuyển khoản đi",amount: 123.32)
        let h2 = History(id: "2",type: "Nộp tiền",amount: 7000000.0)
        let h3 = History(id: "3",type: "Rút tiền",amount: 90000000.0)
        let h4 = History(id: "4",type: "Chuyển khoản đến",amount: 4000000000.0)
        let h5 = History(id: "5",type: "Chuyển khoản đi",amount: 4000000000.0)
        let h6 = History(id: "6",type: "Chuyển khoản đến",amount: 5000000000.0)
        let h7 = History(id: "7",type: "Chuyển khoản đi",amount: 700000000.0)
        let h8 = History(id: "8",type: "Chuyển khoản đi",amount: 80000000.0)
        histories?.append(h1)
        histories?.append(h2)
        histories?.append(h3)
        histories?.append(h4)
        histories?.append(h5)
        histories?.append(h6)
        histories?.append(h7)
        histories?.append(h8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = histories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HistoryCell
        
        if let history = histories?[indexPath.item] {
            cell.history = history
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
}

class HistoryCell: BaseCell {
    var history: History? {
        didSet{
            lbType.text = history?.type
            lbAmount.text = history?.amount?.description
        }
    }
    
    let lbType: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        
        return lb
    }()
    
    let lbAmount: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        
        return lb
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        addSubview(lbType)
        addSubview(lbAmount)
        addSubview(dividerLineView)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: lbType)
        addConstraintsWithFormat(format: "V:|-10-[v0]", views: lbType)
        
        addConstraintsWithFormat(format: "V:[v0]-10-[v1]", views: lbType, lbAmount)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: lbAmount)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
    }
}
