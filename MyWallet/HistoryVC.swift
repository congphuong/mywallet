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
    var histories: [History]? = []
    var loading = true
    
    
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
        setupData(numpage: 5,offset: 0)
    }
    
    func setupData(numpage: Int, offset: Int){
        loading = true
        API.getHistory(numpage: numpage, offset: offset){
            (data, respons, error) in
            if error != nil {
                print(error.debugDescription)
                self.loading = false
            } else {
                print("here")
                //print(data)
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                //print(responseJSON)
                if let responseJSON = responseJSON as? [[String: Any]] {
                    print("here 1")
                    print(responseJSON)
                    DispatchQueue.main.sync {
                      
                    for hsr in responseJSON {
                        
                        let h = History(id: hsr["walletHistoryID"] as! Int, type: hsr["changeType"] as! Int, amount: hsr["changeCost"] as! Double, time: hsr["changeDate"] as! Double)
                            
                            self.histories?.append(h)
                        }
                        self.collectionView?.reloadData()
                        self.loading = false
                    }
                    
                    //print(self.histories as Any)
                    
                }
            }
        }
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == ((histories?.count)! - 3) {
            
        }
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && !loading {
            guard let offet = (self.histories?.last)?.id else {return}
            setupData(numpage: 5, offset: offet)
            
        }
    }
    
}

class HistoryCell: BaseCell {
    var history: History? {
        didSet{
            guard let type = history?.type, let amount = history?.amount, let time = history?.timestamp  else {
                return
            }
            if (type == 1){
                lbType.text = "Chuyển khoản đi"
                lbType.textColor = .red
            }
            if type == 2 {
                lbType.text = "Chuyển khoản đến"
                lbType.textColor = .blue
            }
            if type == 3 {
                lbType.text = "Chuyển khoản"
            }
            lbAmount.text = String(amount) + " vnd"
            
            let date = Date(timeIntervalSince1970: time/1000)
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7") //Set timezone that you want
            //dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            lbDate.text = strDate
        }
    }
    
    let lbType: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = lb.font.withSize(15)
        return lb
    }()
    
    let lbAmount: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        
        return lb
    }()
    
    let lbDate: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.font = lb.font.withSize(12)
        return lb
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        return view
    }()
    
    override func setupViews() {
        addSubview(lbType)
        addSubview(lbAmount)
        addSubview(lbDate)
        addSubview(dividerLineView)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: lbType)
        addConstraintsWithFormat(format: "V:|-5-[v0]", views: lbType)
        
        addConstraintsWithFormat(format: "V:[v0]-10-[v1]-10-[v2]", views: lbType, lbAmount, lbDate)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: lbAmount)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: lbDate)
        
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
