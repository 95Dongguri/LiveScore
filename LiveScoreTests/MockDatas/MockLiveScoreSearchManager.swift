//
//  MockLiveScoreSearchManager.swift
//  LiveScoreTests
//
//  Created by κΉλν on 2022/05/24.
//

import Foundation
@testable import LiveScore

class MockLiveScoreSearchManager: LiveScoreSearchManagerProtocol {
    
    var error: Error?
    var isCalledRequest = false
    
    func request(from dateFrom: String, completionHandler: @escaping ([Result]) -> Void) {
        isCalledRequest = true
        
        if error == nil {
            completionHandler([])
        }
    }
}
