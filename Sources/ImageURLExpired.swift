//
//  ImageURLExpired.swift
//  Kingfisher-iOS
//
//  Created by zwb on 2020/4/10.
//  Copyright © 2020 Wei Wang. All rights reserved.
//

import Foundation

/// Valid url whether expired of image downloader.
public protocol ImageURLValidExpired {
    typealias ValidResult = (image: Image?, expired: Bool)
    
    /// Check whether the url is expired for download.
    /// - Parameter url: The url of image downloader.
    func valid(for url: URL) -> ValidResult
}

struct NoExpired: ImageURLValidExpired {
    static let `default` = NoExpired()
    private init() {}
    
    func valid(for url: URL) -> ValidResult {
        return (nil, false)
    }
}

public struct AnyExpired: ImageURLValidExpired {
    
    let block: (URL) -> ValidResult
    
    public func valid(for url: URL) -> ValidResult {
        return block(url)
    }
    
    public init(valid: @escaping (URL) -> ValidResult ) {
        block = valid
    }
}
