//
//  HomeViewModelTests.swift
//  PruebaCeibaTests
//
//  Created by July Pardo on 11/05/23.
//

import XCTest
@testable import PruebaCeiba

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        let expectation = XCTestExpectation(description: "Fetch users from API")
        viewModel.fetchUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertGreaterThan(self.viewModel.responseUsers.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 6)
    }
    
    func testFilterUsersByName() {
        let testUser1 = User(id: 1, name: "John Doe", username: "jdoe", email: "jdoe@example.com", phone: "1234567890")
        let testUser2 = User(id: 2, name: "Jane Smith", username: "jsmith", email: "jsmith@example.com", phone: "1234567890")
        viewModel.responseUsers = [testUser1, testUser2]
        
        viewModel.filterUsersByName("")
        XCTAssertEqual(viewModel.users, viewModel.responseUsers)
        
        viewModel.filterUsersByName("john")
        XCTAssertEqual(viewModel.users, [testUser1])
        
        viewModel.filterUsersByName("jane")
        XCTAssertEqual(viewModel.users, [testUser2])
        
    }
    
    func testGetUsersFromCoreData() {
        let testUser = User(id: 1, name: "John Doe", username: "jdoe", email: "jdoe@example.com", phone: "1234567890")
        viewModel.saveUsersToCoreData([testUser])
        let users = viewModel.getUsersFromCoreData()
        XCTAssertTrue(users.count > 0)
        XCTAssertEqual(users.first?.id, testUser.id)
        XCTAssertEqual(users.first?.name, testUser.name)
        XCTAssertEqual(users.first?.username, testUser.username)
        XCTAssertEqual(users.first?.email, testUser.email)
        XCTAssertEqual(users.first?.phone, testUser.phone)
    }
}

