//
//  ViewController.swift
//  eticapp
//
//  Created by Baris on 23.09.2021.
//

import UIKit

//image download extension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
//image extension end

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //var urunlerim = [urunlerjson]()
    let data = veriYukleyici().veriTipleri
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        let imgTitleBar = UIImage(named: "logo.png"); self.navigationItem.titleView = UIImageView(image: imgTitleBar)
        
        /*print(data.count)*/
        self.collectionView.reloadData()
        
            }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = data[indexPath.row].title.capitalized
        cell.fiyatLabel.text=data[indexPath.row].price.capitalized
        cell.imageView.contentMode = .scaleAspectFill
        
        let completeLink = data[indexPath.row].imgURL
        
        cell.imageView.downloaded(from: completeLink)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = data[indexPath.row]
        
        performSegue(withIdentifier: "toDetail", sender: row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            let desVC = segue.destination as! ViewController2
            desVC.urun = sender as? urunlerjson
        }
    }
}
  
    
