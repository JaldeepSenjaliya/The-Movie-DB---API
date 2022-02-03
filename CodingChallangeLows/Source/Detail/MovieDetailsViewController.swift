//
//  MovieDetailsViewController.swift
//  CodingChallangeLows
//
//  Created by Divyeshkumar Patel on 2022-01-07.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieDescription: UILabel!
    
    var results: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = results?.title
        releaseDate.text = "Release Date: \(String(describing: results?.release_date ?? " - "))"
        
        let urlString = "https://image.tmdb.org/t/p/w300"+(results?.poster_path ?? " - ")
        guard let url = URL(string: urlString) else { return }
        moviePoster.downloaded(from: url)
        
        movieDescription.text = results?.overview
    }
}

//MARK: - Extension for UIImageView to download image from the Internet
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


