//
//  BPGMarsPhotoDetailViewController.swift
//  Rover
//
//  Created by Bradley GIlmore on 6/22/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class BPGMarsPhotoDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var photo: BPGRoverPhoto? {
        didSet {
            // Update views
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private let client = BPGMarsRoverClient()
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraLabel: UILabel!
    @IBOutlet var solLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    //MARK: - Update
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let photo = photo else {
            imageView.image = #imageLiteral(resourceName: "MarsPlaceholder")
            cameraLabel.text = ""
            solLabel.text = ""
            dateLabel.text = ""
            return
        }
        
        cameraLabel.text = photo.cameraName
        solLabel.text = "\(photo.solDateTaken)"
        dateLabel.text = BPGMarsPhotoDetailViewController.dateFormatter.string(from: photo.earthDate)
        
        let cache = BPGPhotoCache.shared
        if let imageData = cache?.imageData(forIdentifier: photo.photoIdentifier),
            let image = UIImage(data: imageData) {
            imageView.image = image
        } else {
            client.fetchImageData(for: photo) { (data, error) in
                if error != nil || data == nil {
                    NSLog("Error fetching photo for: \(String(describing: error))")
                    return
                }
                
                if let image = UIImage(data: data!),
                    self.photo == photo {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
