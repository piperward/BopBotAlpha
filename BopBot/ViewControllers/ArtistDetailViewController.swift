//
//  ArtistDetailViewController.swift
//  BopBotAlpha
//
//  Created by Piper Ward on 7/8/18.
//  Copyright © 2018 Piper Ward. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    var artistNames: [String] = []
    var albums: [Album] = []
    var artistName: String = ""
    var artist: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        
        artist = Artist(artistName: artistName, albums: albums)
        self.title = artistName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ArtistDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! AlbumCollectionViewCell
        let album = albums[indexPath.row]
        if let artworkUrl = album.artworkUrl100 {
            if let imageUrl = URL(string: artworkUrl) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.collectionArtwork.image = image
                        }
                    }
                    }.resume()
            }
        }
        
        cell.artistNameLabel.text = album.artistName
        cell.collectionNameLabel.text = album.collectionName
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderArtistCollectionReusableView", for: indexPath) as! HeaderArtistCollectionReusableView
        headerViewCell.artist = self.artist
        headerViewCell.delegate = self
        return headerViewCell
    }
}

extension ArtistDetailViewController: HeaderArtistCollectionReusableViewDelegate {
    func updateFollowButton() {
        //
    }
}
