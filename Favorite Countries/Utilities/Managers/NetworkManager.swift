//
//  NetworkManager.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import Foundation

public final class NetworkManager {
    static let shared = NetworkManager()
    
    public init() {}
        
    func getRequest<T: Decodable>(session: URLSession = .shared,
                                  _ endPoint: Endpoint,
                                  type: T.Type) async throws -> T {
        guard let url = endPoint.url else {
            throw FCError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FCError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw FCError.invalidData
        }
    }
}
