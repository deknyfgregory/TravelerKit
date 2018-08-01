//
//  TranslateViewController.swift
//  TravelerKit
//
//  Created by Gregory De knyf on 20/07/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

// -MARK: Properties
class TranslateViewController: UIViewController {
    
    @IBOutlet weak var toBeTranslatedTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// -MARK: Methods
extension TranslateViewController {
    
    override func viewDidLoad() {
        //Observe notification
        NotificationCenter.default.addObserver(self, selector: #selector(showAlertError(_:)), name: .errorTranslate, object: nil)
    }
    
    ///Displays errors
    @objc private func showAlertError(_ notification: Notification) {
        guard let message = notification.userInfo?["error"] as? String else { return }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
