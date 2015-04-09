//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by carlos on 8/4/15.
//  Copyright (c) 2015 Carlos García. All rights reserved.
//

import UIKit
import XCTest

class DetailViewModelTests: XCTestCase, DetailViewModelDelegate {
    
    var detailViewModel: DetailViewModel!
    
    override func setUp() {
        super.setUp()
        Context.defaultContext.paybacks = [Payback]()
        detailViewModel = DetailViewModel(delegate: self)
    }
    
    override func tearDown() {
        super.tearDown()
        detailViewModel.delegate = nil
        resetFlags()
    }
    
    // ----------------------------------------------------------------------------------------
    
    
    func testNoData() {
        detailViewModel.handleDonePressed()
        XCTAssert(!dismissCalled && (invalidNameCalled || invalidAmountCalled))
    }
    
    func testInvalidName() {
        detailViewModel.amount = "84.00"
        
        for name in ["", "Jo", "John", "John ", " John"] {
            detailViewModel.name = name
            
            detailViewModel.handleDonePressed()
            XCTAssert(!dismissCalled && invalidNameCalled)
            resetFlags()
        }
    }
    
    func testInvalidAmount() {
        detailViewModel.name = "John Appleseed"
        
        for amount in ["", "Abc", "A19", "..", "0"] {
            detailViewModel.amount = amount
            
            detailViewModel.handleDonePressed()
            XCTAssert(!dismissCalled && invalidAmountCalled)
            resetFlags()
        }
    }
    
    func testAddPlayback() {
        detailViewModel.name = "John Appleseed"
        detailViewModel.amount = "84.0"
        detailViewModel.handleDonePressed()
        
        let isEqual = Context.defaultContext.paybacks[0] == Payback(firstName: "John", lastName: "Appleseed", createdAt: Context.defaultContext.paybacks[0].createdAt, amount: 84.0)
        XCTAssertTrue(isEqual, "")
    }
    
    func testSavePlayback() {
        detailViewModel.name = "John Appleseed"
        detailViewModel.amount = "84.0"
        detailViewModel.handleDonePressed()
        
        let detailViewModel2 = DetailViewModel(delegate: self, index: 0)
        detailViewModel2.name = "Carlos García"
        detailViewModel2.amount = "90.0"
        detailViewModel2.handleDonePressed()
        
        let isEqual = Context.defaultContext.paybacks[0] == Payback(firstName: "Carlos", lastName: "García", createdAt: Context.defaultContext.paybacks[0].createdAt, amount: 90.0)
        XCTAssertTrue(isEqual)
    }
    
    // ----------------------------------------------------------------------------------------
    
    
    
    // ----------------------------------------------------------------------------------------
    
    var dismissCalled = false
    var invalidNameCalled = false
    var invalidAmountCalled = false
    
    func resetFlags() {
        dismissCalled = false
        invalidNameCalled = false
        invalidAmountCalled = false
    }
    
    func dismissAddView() {
        dismissCalled = true
    }
    
    func showInvalidName() {
        invalidNameCalled = true
    }
    
    func showInvalidAmount() {
        invalidAmountCalled = true
    }
}
