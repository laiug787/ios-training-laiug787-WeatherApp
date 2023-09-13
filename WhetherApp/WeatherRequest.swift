//
//  WeatherRequest.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherRequest: Encodable {
    let area: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case area
        case date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(area, forKey: .area)
        try container.encode(date.yyyyMMddTHHmmssZZZZZ, forKey: .date)
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

private extension DateFormatter {
    static var yyyyMMddTHHmmssZZZZZ: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }
}

private extension Date {
    var yyyyMMddTHHmmssZZZZZ: String {
        DateFormatter.yyyyMMddTHHmmssZZZZZ.string(from: self)
    }
}


