//
//  ListViewModelTests.swift
//  MVVM
//
//  Created by carlos on 8/4/15.
//  Copyright (c) 2015 Carlos García. All rights reserved.
//

import UIKit
import XCTest

class ListViewModelTests: XCTestCase, DetailViewModelDelegate {
    
    var list: ListViewModel!
    var detail: DetailViewModel!

    override func setUp() {
        super.setUp()
        Context.defaultContext.paybacks = [Payback]()
        list = ListViewModel()
        detail = DetailViewModel(delegate: self)
    }
    
    override func tearDown() {
        super.tearDown()
        detail.delegate = nil
    }
    
    // ----------------------------------------------------------------------------------------
    
    func testEmpty() {
        let items = list.items
        XCTAssert(items.isEmpty)
    }
    
    func testNotEmpty() {
        detail.name = "John Appleseed"
        detail.amount = "84"
        detail.handleDonePressed()
        
        list.refresh()
        XCTAssertTrue(list.items.count == 1)
        XCTAssertTrue(list.items[0].title == "John A.")
    }
    
    func testDelete() {
        detail.name = "John Appleseed"
        detail.amount = "84"
        detail.handleDonePressed()
        
        list.refresh()
        XCTAssertTrue(list.items.count == 1)
        list.removePayback(0)
        list.refresh()
        XCTAssertTrue(list.items.count == 0)
    }
    
    // ----------------------------------------------------------------------------------------
    
    func showAddView() {
    }
    
    func dismissAddView() {
    }
    
    func showInvalidAmount() {
    }
    
    func showInvalidName() {
    }

}
