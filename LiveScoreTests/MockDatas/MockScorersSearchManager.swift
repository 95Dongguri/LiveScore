//
//  MockScorersSearchManager.swift
//  LiveScoreTests
//
//  Created by κΉλν on 2022/05/24.
//

import Foundation
@testable import LiveScore

class MockScorersSearchManager: ScorersSearchManagerProtocol {
    
    var error: Error?
    var isCalledRequest = false
    
    func request(from league: String, completionHandler: @escaping ([Scorers]) -> Void) {
        isCalledRequest = true
        
        if error == nil {
            completionHandler([])
        }
    }
}
