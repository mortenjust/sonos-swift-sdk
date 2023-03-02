//
//  File.swift
//  
//
//  Created by James Hickman on 2/24/21.
//

import Foundation
import SwiftyJSON

public struct Favorite: Identifiable {
    
    public var id: String
    public var name: String
    public var description: String
    public var imageUrl: URL?
    public var imageCompilation: [URL]?
    public var service: Service?
    
    init?(_ data: Any) {
        
        let json = JSON(data)
        guard let id = json["id"].string,
              let name = json["name"].string,
              let description = json["description"].string else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = json["imageUrl"].url
        
        var urls: [URL] = []
        if let imageCompilationStrings = json["imageCompilation"].array?.map({ $0.stringValue }) {
            for urlString in imageCompilationStrings {
                if let url = URL(string: urlString) {
                    urls.append(url)
                }
            }
            self.imageCompilation = urls
        }
        
    }
}



extension Favorite : Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, description, imageUrl, imageCompilation, service
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        imageUrl = try values.decode(URL.self, forKey: .imageUrl)
        imageCompilation = try values.decode([URL].self, forKey: .imageCompilation)
        service = try values.decode(Service.self, forKey: .service)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(imageCompilation, forKey: .imageCompilation)
        try container.encode(service, forKey: .service)
    }
    
    
}
