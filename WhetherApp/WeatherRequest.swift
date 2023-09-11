//
//  WeatherRequest.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherRequest: Codable {
    var area: String
    var date: Date
    
    init(area: String, date: Date) {
        self.area = area
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case area
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.area = try container.decode(String.self, forKey: .area)
        self.date = try container.decode(String.self, forKey: .date).date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(area, forKey: .area)
        try container.encode(date.string, forKey: .date)
    }
    
    func encodeToString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase

        do {
            let jsonData = try encoder.encode(self)
            guard let string = String(data: jsonData, encoding: .utf8) else {
                fatalError("Fail to convert Data to String")
            }
            return string
        } catch {
            fatalError("Fail to convert WeatherRequest to String")
        }
    }
}

extension Date {
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.string(from: self)
    }
}

extension String {
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self)!
    }
}


