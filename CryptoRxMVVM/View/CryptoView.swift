//
//  ViewController.swift
//  CryptoRxMVVM
//
//  Created by Gizem Zorlu on 27.11.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CryptoView: UIViewController, UITableViewDelegate/*, UITableViewDataSource */{
    
    let identifier = "CryptoCell"
    
    let viewModel = CryptoViewModel()
    let disposeBag = DisposeBag()

    var tableView = UITableView()
    var cryptoList = [Crypto]()
    let indicatorView = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerTableView()
        setupBindings()
        viewModel.requestData()
    }

    private func setupBindings() {
        viewModel
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }.disposed(by: disposeBag)
        
//        viewModel
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoList = cryptos
//                self.tableView.reloadData()
//            }.disposed(by: disposeBag)
        
        viewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                cell.item = item
            } .disposed(by: disposeBag)
    }
    
    
    func setupUI() {
        
        view.backgroundColor = .black
        
        tableView.backgroundColor = .black
//        tableView.delegate = self
//        tableView.dataSource =  self
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        indicatorView.style = .large
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func registerTableView() {
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CryptoTableViewCell
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}

