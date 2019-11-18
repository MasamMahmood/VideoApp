//
//  BoxViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 03/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
import AVKit
//import Appodeal

class BoxViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var containerView: UIView!
    private var service: IBoxesService = ServiceProvider.instance.boxService
    var boxId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.openBox(userId: "niltest", boxId: boxId!, completion: {[weak self] box in
            guard let box = box else { return }
            
            //Appodeal.showAd(.interstitial, forPlacement: box.animationUrl, rootViewController: self!)
            //Appodeal.isReadyForShow(with: .interstitial)
            
            let avPlayer = AVPlayer(playerItem: AVPlayerItem(url: URL(string: box.animationUrl)!))
            let avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayer.frame = self!.containerView.bounds
            self!.containerView.layer.insertSublayer(avPlayerLayer, at: 0)
            self!.imgView.isHidden = true
            avPlayer.play()
            avPlayer.automaticallyWaitsToMinimizeStalling = false
            self?.btnLabel.setTitle(box.title, for: .normal)
                   
        })
        

    }
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openBtn(_ sender: Any) {
        
        service.openBox(userId: "niltest", boxId: boxId!, completion: {[weak self] box in
            guard let box = box else { return }
            self!.containerView.isHidden = true
            self!.imgView.isHidden = false
            self!.setImage(from: box.prizeUrl!)
            self?.btnLabel.setTitle(box.status, for: .normal)
            if let code = box.code {
                if code != " " {
                UIPasteboard.general.string = box.code
                let alertController = UIAlertController(title: "Prize Code", message: "Prize code copied", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("Ok button tapped");
                    
                }
                alertController.addAction(OKAction)
                self!.present(alertController, animated: true, completion:nil)
                }
            }
                   
        })
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imgView.image = image
            }
        }
    }
    
}
