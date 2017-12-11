//
//  GenerateQRVC.swift
//  MyWallet
//
//  Created by congphuong on 11/25/17.
//  Copyright © 2017 congphuong. All rights reserved.
//

import UIKit

class GenerateQRVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Tạo code"
        
        setupView()
    }
    
    let txtCost: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        txt.keyboardType = .decimalPad
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        return txt
    }()
    
    let txtNote: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        return txt
    }()
    
    let btGenerate: UIButton = {
        let bt = UIButton()
        bt.setTitle("Generate", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .lightGray
        bt.translatesAutoresizingMaskIntoConstraints = false
        
        return bt
    }()
    
    @objc func btGenerateClick(){
        let codeDetail = QRCodeDetailVC()
        codeDetail.code = txtCost.text! + ":" + txtNote.text!
        codeDetail.view.backgroundColor = .white
        navigationController?.pushViewController(codeDetail, animated: true)
        
    }
    
    private func setupView() {
        let lbCost = UILabel()
        lbCost.text = "Số Tiền"
        let lbNote = UILabel()
        lbNote.text = "Ghi chú"
        btGenerate.addTarget(self, action: #selector(btGenerateClick), for: .touchUpInside)
        
        let contain = UIStackView(arrangedSubviews: [lbCost,txtCost,lbNote,txtNote, btGenerate])
        contain.axis = .vertical
        contain.spacing = 20
        contain.layoutMargins = UIEdgeInsetsMake(20, 20, 20, 20)
        contain.isLayoutMarginsRelativeArrangement = true
        contain.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(contain)
        NSLayoutConstraint.activate([
            contain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
}
