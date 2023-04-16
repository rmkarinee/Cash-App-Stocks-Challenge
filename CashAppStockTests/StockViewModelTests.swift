//
//  StockViewModelTests.swift
//  CashAppStockTests
//
//  Created by Karine Mendonça on 2023-04-15.
//

import XCTest
@testable import CashAppStock

final class StockViewModelTests: XCTestCase {
    
    var viewModel = StockViewModel()
    var stockMock = MockTests()
    
    override func setUp() {
       super.setUp()

        
    }
    override func tearDown() {
       super.tearDown()
        viewModel.stockItems = []
    }
    
    func testNumberOfItens() {
        // Given
        viewModel.stockItems = stockMock.createStocksJson()
        
        // When
        let count = viewModel.numberOfItens()
        
        // Then
        XCTAssertEqual(count, 4)
    }
    
    func testPriceConvert() {
        // Given
        viewModel.stockItems = stockMock.createStocksJson()
        
        // When
        let firstPrice = viewModel.priceConvert(viewModel.stockItems[0].current_price_cents)
        let secondPrice = viewModel.priceConvert(viewModel.stockItems[1].current_price_cents)
        let thirdrice = viewModel.priceConvert(viewModel.stockItems[2].current_price_cents)
        let fourthPrice = viewModel.priceConvert(viewModel.stockItems[3].current_price_cents)
        
        // Then
        XCTAssertEqual(firstPrice, "38.33")
        XCTAssertEqual(secondPrice, "3181.57")
        XCTAssertEqual(thirdrice, "36.14")
        XCTAssertEqual(fourthPrice, "23.93")
    }

    func testConvertToDate() {
        // Given
        viewModel.stockItems = stockMock.createStocksJson()
        
        // When
        let timeFirst = viewModel.convertToDate(viewModel.stockItems[0].current_price_timestamp)
        let timeSecond = viewModel.convertToDate(viewModel.stockItems[1].current_price_timestamp)
        let timeThird = viewModel.convertToDate(viewModel.stockItems[2].current_price_timestamp)
        let timeFourth = viewModel.convertToDate(viewModel.stockItems[3].current_price_timestamp)
        
        // Then
        XCTAssertEqual(timeFirst, "11/11/2021 02:08")
        XCTAssertEqual(timeSecond, "11/11/2021 02:08")
        XCTAssertEqual(timeThird, "11/11/2021 02:08")
        XCTAssertEqual(timeFourth, "11/11/2021 02:08")
    }
}
