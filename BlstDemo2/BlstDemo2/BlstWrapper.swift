//
//  BlstWrapper.swift
//  BlstDemo2
//
//  Created by 10191280 on 2024/10/22.
//

import Foundation
import BlstSwift

// 封装BLST库中的各种功能
public class BlstWrapper {
    
    // 签名
    /**
     message: 数据
     secretKey: 私钥key
     publicKey: 公钥
     */
    public static func sign(message: Data, secretKey: String, publicKey: Data) throws -> Data? {
        guard let data = "BLS_SIG_BLS12381G2_XMD:SHA-256_SSWU_RO_NUL_".data(using: .utf8) else { return nil }
        
        let dst = DomainSeperationTag(data: data)
        
        let secretKey = try SecretKey(
            decimalString: secretKey
        )
        let publicKey = try PublicKey(compressedData: publicKey)
        if secretKey.publicKey() != publicKey {
            return nil
        }
        let signature = try secretKey.sign(
            message: message,
            domainSeperationTag: dst
        )
        return try signature.affine().compressedData()
    }

    // 验证单个签名
    public static func verify(signature: Data, message: Data, secretKey: String, publicKey: Data) async throws -> Bool {
        
        guard let data = "BLS_SIG_BLS12381G2_XMD:SHA-256_SSWU_RO_NUL_".data(using: .utf8) else { return false }
        
        let dst = DomainSeperationTag(data: data)
        let secretKey = try SecretKey(
            decimalString: secretKey
        )
        
        let signature = try secretKey.sign(
            message: message,
            domainSeperationTag: dst
        )

        //VERIFY
        let publicKey = try PublicKey(compressedData: publicKey)
        let isSignatureValid = try await signature.verify(
            publicKey: publicKey,
            message: message,
            domainSeperationTag: dst
        )
        return isSignatureValid
    }
}
