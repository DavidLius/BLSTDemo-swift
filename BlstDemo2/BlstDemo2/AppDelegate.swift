//
//  AppDelegate.swift
//  BlstDemo2
//
//  Created by 10191280 on 2024/10/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Task {
            let message = "1234"
            guard let messData = message.data(using: .utf8) else {return}
            let publicKey = "mB3i2IqAotd1Ls2mZEM0Cniepi3WjcpqOoyvO2welCSKiBmk9rpVT1D1zLi8QOZ8"
            guard let publicData = Data(base64Encoded: publicKey) else {return}
            let privateKey = "49702461028268182420606074237888227477973439590128745083263225875180465421919"
            do {
                let signature = try BlstWrapper.sign(message: messData, secretKey: privateKey, publicKey: publicData)
                debugPrint("[DEBUG]: sign value:\(String(describing: signature))")
                guard let signature = signature else { return }
                // 验证成功的案例
                 let verifysuccess = try await BlstWrapper.verify(signature: signature, message: messData, secretKey: privateKey, publicKey: publicData)
                debugPrint("[DEBUG]: verifysuccess:\(verifysuccess)")
                // 验证失败的案例(更改私钥)
                let privateKey2 = "49702461028268182420606074237888227477973439590128745083263225875180465421910" // 最后一个 9 改为 0
                let verifyfail = try await BlstWrapper.verify(signature: signature, message: messData, secretKey: privateKey2, publicKey: publicData)
               debugPrint("[DEBUG]: verifyfail:\(verifyfail)")
                
                // 验证失败的案例(更改公钥)
                let publicKey2 = "mB3i2IqAotd1Ls2mZEM0Cniepi3WjcpqOoyvO2welCSKiBmk9rpVT1D1zLi8QOZ8"
                guard let publicData2 = Data(base64Encoded: publicKey2) else { return }
                let verifyfail2 = try await BlstWrapper.verify(signature: signature, message: messData, secretKey: privateKey, publicKey: publicData2)
                debugPrint("[DEBUG]: verifyfail2:\( verifyfail2)")
                
                
            } catch {
                debugPrint("\(error.localizedDescription)")
            }
        }

    }

}

