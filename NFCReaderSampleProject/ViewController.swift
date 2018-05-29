//
//  ViewController.swift
//  NFCReaderSampleProject
//
//  Created by HengVisal on 5/25/18.
//  Copyright © 2018 HengVisal. All rights reserved.
//

import UIKit
import SnapKit
import CoreNFC

class ViewController: UIViewController , NFCNDEFReaderSessionDelegate{
   
    var nfcSession : NFCNDEFReaderSession!
    var scanBtn : UIButton!
    var messageLbl : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        createComponent()
        addSupview()
        setupLayout()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was Invalid" , error)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)! // 1
        }
        
        DispatchQueue.main.async {
            self.messageLbl.text = result
        }
    }
}


// MARK: - Create UI Component
extension ViewController{
    func createComponent() -> Void {
        
        // Scan Button
        scanBtn = UIButton()
        scanBtn.backgroundColor = UIColor.blue
        scanBtn.setTitle("SCAN", for: .normal)
        scanBtn.addTarget(self, action: #selector(scanAction), for: .touchUpInside)
        
        // Message Label
        messageLbl = UILabel()
        messageLbl.text = "PRESS SCAN TO SCAN YOUR CARD"
        messageLbl.numberOfLines = 0
        messageLbl.textColor = UIColor.black
        messageLbl.textAlignment = .center
        messageLbl.font = messageLbl.font.withSize(20)
    }
    
    // Scan Button Action
    @objc func scanAction () -> Void {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.begin()
    }
}

// MARK: - Add Supview
extension ViewController{
    func addSupview() -> Void {
        self.view.addSubview(scanBtn)
        self.view.addSubview(messageLbl)
    }
}

// MARK: - Setup UI Layout
extension ViewController {
    func setupLayout() -> Void {
        
        // Scan Button
        scanBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        // Message Label
        messageLbl.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-100)
            
        }
    }
}
