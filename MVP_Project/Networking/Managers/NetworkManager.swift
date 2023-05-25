//
//  NetworkManager.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import Foundation

enum NetworkError: Error {
    case urlNotValid
    case failedToCreateURL
    case dataNotFound
}

protocol NetworkService: AnyObject {
    var cryptoManager: CryptoService { get }
    
    func fetch<T: Decodable>() async throws -> T?
}

final class NetworkManager: NetworkService {
    
    var cryptoManager: CryptoService {
        return CryptoManager()
    }
    
    func fetch<T: Decodable>() async throws -> T? {
        let timestamp = String(Date().timeIntervalSince1970)
        let urlHash = cryptoManager
            .createHash(timestamp,
                        publicKey: MarvelKey.publicKey,
                        privateKey: MarvelKey.privateKey)
        let urlString = MarvelAPI.gateWayComics + urlHash
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.urlNotValid
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let items = try JSONDecoder()
                .decode(T.self, from: data)
            return items
        } catch {
            throw NetworkError.dataNotFound
        }
    }
    
    init() {}
}

extension NetworkService {
    func printJSON(_ data: Data) {
        do {
            if let json = try JSONSerialization
                .jsonObject(with: data, options: []) as? [String: Any] {
                let jsonData = try JSONSerialization
                    .data(withJSONObject: json, options: [.prettyPrinted])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        } catch {
            print("Ошибка десериализации JSON: \(error)")
        }
    }
}
