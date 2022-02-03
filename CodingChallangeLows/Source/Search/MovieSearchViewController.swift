//
//  MovieSearchViewController.swift
//  CodingChallangeLows
//
//  Created by Divyeshkumar Patel on 2022-01-07.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var searchBarOutlet: UISearchBar!
    @IBOutlet var goButtonOutlet: UIButton!
    @IBOutlet var movieSearchtableView: UITableView!
    
    var results: [MovieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBAction
    @IBAction func goButtonTapped(_ sender: UIButton) {
        
        searchBarOutlet.resignFirstResponder()
        if let text = searchBarOutlet.text {
            results = []
            movieSearchtableView?.reloadData()
            fetchMovieDetails(query: text)
            searchBarOutlet.text = ""
        }
    }
    
    //MARK: - JSON Decoding
    func fetchMovieDetails(query: String) {
        
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.APIKey)&language=en-US&page=1&include_adult=false&query=\(query)"
        
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(Main.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.movieSearchtableView?.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

//MARK: - Extension for MovieSearchController conforming UITableViewDataSource and UITableViewDelegate

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCell, for: indexPath) as! MovieSearchTableViewCell
        
        cell.movieName.text = results[indexPath.row].title
        cell.releaseDate.text = results[indexPath.row].release_date
        cell.rating.text = String(results[indexPath.row].vote_average)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.movieDetailsVCSeguae, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MovieDetailsViewController {
            destinationVC.results = results[(movieSearchtableView.indexPathForSelectedRow?.row)!]
        }
    }
}
