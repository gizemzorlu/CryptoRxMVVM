//
//  CryptoTableViewCell.swift
//  CryptoRxMVVM
//
//  Created by Gizem Zorlu on 28.11.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    let identifier = "CryptoCell"
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    
    public var item: Crypto! {
        didSet {
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: identifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = .black
        
        nameLabel.text = "Gizem Zorlu"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).inset(10)
            make.left.equalToSuperview().offset(25)
        }
        
        priceLabel.text = "iOS Developer"
        priceLabel.textColor = .white
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.sizeToFit()
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(8)
            make.left.equalTo(nameLabel.snp.left)
        }
    }
}
