//
//  StockTableViewCell.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-12.
//

import UIKit

class StockTableViewCell: UITableViewCell {
    
    static let identifier = "stockCell"
    var viewModel = StockViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "StockTableViewCell", bundle: nil)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var tickerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setUpCell(_ item: StockItem) {
        tickerLabel.text = item.ticker
        nameLabel.text = "Name: \(item.name)"
        currencyLabel.text = "Currency: \(item.currency)"
        priceLabel.text = viewModel.priceConvert(item.current_price_cents)
        dateTimeLabel.text = "Date/Time: \(String(item.current_price_timestamp)) "
        
        if let quantity = item.quantity {
            quantityLabel.text = "Quantity: \(String(quantity))"
        } else {
            return quantityLabel.text = "Quantity: Unavailable "
        }
    }
}

extension StockTableViewCell: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(tickerLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(dateTimeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 150),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
}
