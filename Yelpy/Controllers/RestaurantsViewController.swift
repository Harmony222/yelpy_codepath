//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() { (restaurants) in guard let restaurants = restaurants else {
            return
        }
        print(restaurants)
        self.restaurantsArray = restaurants
        self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurantsArray[indexPath.row]
        
        // Set label to restaurant name for each cell
        cell.label.text = restaurant["name"] as? String ?? ""
        
        // Set restaurant category label
        var categories: [Any] = []
        categories = restaurant["categories"] as! [Any]
//        print(categories[0])
        let dict = categories[0] as? [String: Any]
        cell.typeLabel.text = dict?["title"] as? String ?? ""
        
        // Set rating stars image
        let rating = restaurant["rating"]!!
        let rating_string = "\(rating)"
        let rating_dict = [
            "0": "small_0",
            "1": "small_1",
            "1.5": "small_1_half",
            "2": "small_2",
            "2.5": "small_2_half",
            "3": "small_3",
            "3.5": "small_3_half",
            "4": "small_4",
            "4.5": "small_4_half",
            "5": "small_5"
        ]
        // default to zero stars if there is no rating
        let ratingImage = UIImage(named: rating_dict[rating_string] ?? "small_0")
        cell.starsImage.image = ratingImage
            
        // Set review count label
        let review_count = restaurant["review_count"]!!
        let review_count_string = "\(review_count)" + " Reviews"
        cell.countLabel.text = review_count_string
        
        // Set phone number label
        cell.phoneLabel.text = restaurant["display_phone"] as? String ?? ""
                
        // Set Image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        return cell
    }
    

}

// ––––– TODO: Create tableView Extension and TableView Functionality


