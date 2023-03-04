//
//  File.swift
//  
//
//  Created by James Hickman on 2/24/21.
//

import Foundation
import SwiftyJSON

public struct Service: Identifiable {
    
    public var id: String?
    public var name: String
    public var imageUrl: String?
    
    init?(_ data: Any) {
        
        let json = JSON(data)
        guard let name = json["name"].string else { return nil }
        
        self.id = json["id"].string
        self.name = name
        self.imageUrl = json["imageUrl"].string
    }

}


extension Service : Codable {
//    enum CodingKeys : String, CodingKey {
//        case id, name, imageUrl
//    }
//    
//    public init(from decoder: Decoder) throws {
//        
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        name = try values.decode(String.self, forKey: .name)
//        imageUrl = try values.decode(String.self, forKey: .imageUrl)
//    }
//    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(imageUrl, forKey: .imageUrl)
//        
//    }
    
}


extension Service : Hashable {
    
}
