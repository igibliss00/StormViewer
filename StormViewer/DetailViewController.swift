//
//  DetailViewController.swift
//  StormViewer
//
//  Created by jc on 2020-06-20.
//  Copyright © 2020 J. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var viewCountLabel: UILabel!
    
    var selectedImage: String?
    var row: Int = 0
    var total: Int = 0
    var viewCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(row + 1) of \(total)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        let defaults = UserDefaults.standard
        if let selectedImage = selectedImage {
            viewCount = defaults.integer(forKey: selectedImage)
            viewCount += 1
            viewCountLabel.text = String(viewCount)
        } else {
            print("Could not load the view count")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
        
        let d = UserDefaults.standard
        if let selectedImage = selectedImage {
            d.set(viewCount, forKey: selectedImage)
        } else {
            print("Could not save the view count")
        }
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
//    func saveViewCount() {
//        let jsonEncoder = JSONEncoder()
//        if let savedData = try? jsonEncoder.encode(viewCount) {
//            let defaults = UserDefaults.standard
//            if let selectedImage = selectedImage {
//                defaults.set(savedData, forKey: selectedImage)
//            }
//        } else {
//            print("Failed to save people")
//        }
//    }
//
//    func loadViewCount() {
//        let defaults = UserDefaults.standard
//
//    }
}

