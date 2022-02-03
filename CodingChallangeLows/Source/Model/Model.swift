//
//  MovieData.swift
//  CodingChallangeLows
//
//  Created by Divyeshkumar Patel on 2022-01-07.
//

import Foundation
import UIKit

struct Main: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    let overview: String
    let release_date: String
    let poster_path: String?
    let title: String
    let vote_average: Double
}



	
