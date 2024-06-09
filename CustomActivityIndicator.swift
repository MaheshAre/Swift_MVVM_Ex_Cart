//
//  CustomActivityIndicator.swift
//  MVVM_Example
//
//  Created by ajay on 09/06/24.
//

import Foundation
import UIKit

class CustomActivityIndicator {
    static let shared = CustomActivityIndicator() // Singleton instance
    
    private var activityIndicator: UIActivityIndicatorView
    
    private init() {
        // Initialize activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        
        // Get the first window
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                // Center indicator in the middle of the screen
                activityIndicator.center = window.center
                window.addSubview(activityIndicator)
            }
        }

    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

