//
//  URL+Extensions.swift
//  Entain
//
//  Created by BS Entain on 24/6/2024.
//

import Foundation

extension URL {
    mutating func appendQueryItem(_ item: URLQueryItem) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        queryItems.append(item)
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
        self = url
    }

    mutating func appendQueryItems(_ items: [URLQueryItem]) {
        for item in items { appendQueryItem(item) }
    }

    mutating func appendQueryItems(_ items: [String: Any]) {
        for item in items {
            let value = String(describing: item.value)
            let queryItem = URLQueryItem(name: item.key, value: value)
            appendQueryItem(queryItem)
        }
    }
}
