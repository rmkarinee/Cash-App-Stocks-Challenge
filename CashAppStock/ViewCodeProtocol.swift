//
//  ViewCodeProtocol.swift
//  CashAppStock
//
//  Created by Karine Mendonça on 2023-04-13.
//

import Foundation

protocol ViewCodeProtocol {

    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewCodeProtocol {

    func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }

    func buildViewHierarchy() {}
    func setupConstraints() {}

}
