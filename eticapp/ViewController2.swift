//
//  ViewController2.swift
//  eticapp
//
//  Created by Baris on 21.10.2021.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var labelAlt: UILabel!
    var urun:urunlerjson!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        label2.text = urun.title
        labelAlt.text = urun.price
        let completeLink = urun.imgURL
        imageView2.downloaded(from: completeLink)
    }
    
}
