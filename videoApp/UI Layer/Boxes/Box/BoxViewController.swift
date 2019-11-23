//
//  BoxViewController.swift
//  videoApp
//
//  Created by Olga Vorona on 03/11/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit
import AVKit
import Toast_Swift
//import Appodeal

class BoxViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewPlay: VideoView!
    private var service: IBoxesService = ServiceProvider.instance.boxService
    var boxId:String?
    var player: AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.openBox(userId: "niltest", boxId: boxId!, completion: {[weak self] box in
            guard let box = box else { return }
            
            //Appodeal.showAd(.interstitial, forPlacement: box.animationUrl, rootViewController: self!)
            //Appodeal.isReadyForShow(with: .interstitial)
            
            self!.viewPlay.configure(url: box.animationUrl)
            self?.viewPlay.play()
            
            NotificationCenter.default.addObserver(self!, selector: #selector(self!.playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            
            
                   
        })
        

    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        service.openBox(userId: "niltest", boxId: boxId!, completion: {[weak self] box in
            guard let box = box else { return }
           // self!.containerView.isHidden = true
            self!.imgView.isHidden = false
            self!.setImage(from: box.prizeUrl!)
            self!.viewPlay.isHidden = true
            if let code = box.code {
                if code != " " {
                UIPasteboard.general.string = box.code
                var style = ToastStyle()
                style.messageColor = .black
                style.backgroundColor = .white
                    self!.view.makeToast("Code Copied", duration: 3.0, position: .bottom, style: style)
                }
            }
                   
        })
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
