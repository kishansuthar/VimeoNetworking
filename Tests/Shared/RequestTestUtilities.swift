//
//  RequestTestUtilities.swift
//  VimeoNetworkingExample-iOSTests, VimeoNetworkingExample-tvOSTests
//
//  Created by Westendorf, Mike on 5/21/17.
//  Copyright © 2016 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
@testable import VimeoNetworking

class RequestComparisons {
    static let CompareRetryPolicies = { (policyToTest: RetryPolicy, comparePolicy: RetryPolicy) -> Bool in
        switch policyToTest {
        case .singleAttempt:
            switch comparePolicy {
            case .singleAttempt:
                return true
            default:
                return false
            }
        default:
            if case .multipleAttempts(let attemptCount, let initialDelay) = policyToTest,
                case .multipleAttempts(let testValueCount, let testDelay) = comparePolicy {
                return attemptCount == testValueCount && initialDelay == testDelay
            }
            
            return false
        }
    }
    
    static func ValidateDefaults<ModelType>(request: Request<ModelType>) -> Bool {
        return request.method == .get
            && request.parameters == nil
            && request.modelKeyPath == nil
            && request.cacheResponse == false
            && request.useCache == false
            && RequestComparisons.CompareRetryPolicies(request.retryPolicy, .singleAttempt)
    }
}
