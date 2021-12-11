//
//  MyAlertViewController.swift
//  My Project (Chating)
//
//  Created by Najd Alquarishi on 11/12/2021.
//

import Foundation
import CleanyModal

class MyAlertViewController: CleanyAlertViewController {
    init(title: String?, message: String?, imageName: String? = nil, preferredStyle: CleanyAlertViewController.Style = .alert) {
        let styleSettings = CleanyAlertConfig.getDefaultStyleSettings()
        styleSettings[.tintColor] = .systemBlue
        styleSettings[.destructiveColor] = .systemRed
        super.init(title: title, message: message, imageName: imageName, preferredStyle: preferredStyle, styleSettings: styleSettings)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
