//
//  PublishJobConnection.swift
//  VimeoNetworking
//
//  Copyright © 2019 Vimeo. All rights reserved.
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

@objcMembers
public class PublishJobConnection: VIMConnection {
    public private(set) var publishBlockers: PublishJobBlockers?
    public private(set) var publishConstraints: PublishJobConstraints?
    public private(set) var publishDestinations: PublishJobDestinations?
    
    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.publishBlockers:
            return PublishJobBlockers.self
        case String.Key.publishConstraints:
            return PublishJobConstraints.self
        case String.Key.publishDestinations:
            return PublishJobDestinations.self
        default:
            return nil
        }
    }
}

@objcMembers
public class PublishJobBlockers: VIMModelObject {
    public private(set) var facebook: [String]?
    public private(set) var youtube: [String]?
    public private(set) var linkedin: [String]?
    public private(set) var twitter: [String]?
}

@objcMembers
public class PublishJobConstraints: VIMModelObject {
    public private(set) var facebook: PublishConstraints?
    public private(set) var youtube: PublishConstraints?
    public private(set) var linkedin: PublishConstraints?
    public private(set) var twitter: PublishConstraints?

    public override func getClassForObjectKey(_ key: String?) -> AnyClass? {
        switch key {
        case String.Key.facebook,
             String.Key.youtube,
             String.Key.linkedin,
             String.Key.twitter:
            return PublishConstraints.self
        default:
            return nil
        }
    }
}

@objcMembers
public class PublishJobDestinations: VIMModelObject {
    public private(set) var publishedToFacebook: NSNumber?
    public private(set) var publishedToLinkedIn: NSNumber?
    public private(set) var publishedToTwitter: NSNumber?
    public private(set) var publishedToYouTube: NSNumber?

    @nonobjc public lazy var facebook: Bool = {
        return self.publishedToFacebook?.boolValue == true
    }()

    @nonobjc public lazy var linkedin: Bool = {
        return self.publishedToLinkedIn?.boolValue == true
    }()

    @nonobjc public lazy var twitter: Bool = {
        return self.publishedToTwitter?.boolValue == true
    }()

    @nonobjc public lazy var youtube: Bool = {
        return self.publishedToYouTube?.boolValue == true
    }()

    public override func getObjectMapping() -> Any! {
        return [
            String.Key.facebook: String.Value.facebook,
            String.Key.linkedin: String.Value.linkedin,
            String.Key.twitter: String.Value.twitter,
            String.Key.youtube: String.Value.youtube
        ]
    }
}

@objcMembers
public class PublishConstraints: VIMModelObject {
    public private(set) var duration: NSNumber?
    public private(set) var size: NSNumber?
}

private extension String {
    struct Key {
        static let publishBlockers = "publish_blockers"
        static let publishConstraints = "publish_constraints"
        static let publishDestinations = "publish_destinations"
        static let facebook = "facebook"
        static let youtube = "youtube"
        static let linkedin = "linkedin"
        static let twitter = "twitter"
    }

    struct Value {
        static let facebook = "publishedToFacebook"
        static let linkedin = "publishedToLinkedIn"
        static let twitter = "publishedToTwitter"
        static let youtube = "publishedToYouTube"
    }

    struct Blockers {
        static let size = "SIZE"
        static let duration = "DURATION"
        static let facebookNoPages = "FP_NO_PAGES"
        static let linkedInNoOrganizations = "LI_NO_ORGANIZATIONS"
    }

    struct Constraints {
        static let size = "size"
        static let duration = "duration"
    }
}
