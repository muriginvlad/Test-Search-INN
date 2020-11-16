//
//  ru_hire_iosTests.swift
//  ru_hire_iosTests
//
//  Created by Владислав on 10.11.2020.
//

import XCTest
@testable import ru_hire_ios

class ru_hire_iosTests: XCTestCase {

    func testOrganizationFullFataSetGet() {
        let data = OrganizationFullData(fullNameOrganization: "Сбер", innOrganization: "11111", addressOrganization: "г.Москва")
        XCTAssertEqual(data?.fullNameOrganization, "Сбер")
        XCTAssertEqual(data?.innOrganization, "11111")
        XCTAssertEqual(data?.addressOrganization, "г.Москва")
    }

}
