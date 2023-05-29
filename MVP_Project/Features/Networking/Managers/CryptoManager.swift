//
//  CryptoManager.swift
//  MVP_Project
//
//  Created by Aleksei on 23.05.2023.
//

import Foundation
import CryptoKit

protocol CryptoService: AnyObject {
    func createHash(_ timestamp: String, publicKey: String, privateKey: String) -> String
}

final class CryptoManager: CryptoService {
    
    func createHash(_ timestamp: String, publicKey: String, privateKey: String) -> String {
        let hash = formatedMD5(string: timestamp + privateKey + publicKey)
        let stringHash = "ts=" + timestamp + "&apikey=" + publicKey + "&hash=" + hash
        
        return stringHash
    }
    
    private func formatedMD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    init() {}
}
