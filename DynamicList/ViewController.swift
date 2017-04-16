//
//  ViewController.swift
//  DynamicList
//
//  Created by Łukasz Marczak on 09.04.2017.
//  Copyright © 2017 Łukasz Marczak. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift


class TableViewController: UITableViewController  {
    
    var arrayOfCellData = [Poke]()
    
    override func viewDidLoad() {
        arrayOfCellData = [
            Poke(name:"bulbasaur"),
            Poke(name:"charmander"),
            Poke(name:"squirtle"),
            Poke(name:"pikachu")]
        
        fetchNewData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return arrayOfCellData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentItem = arrayOfCellData[indexPath.row];
        
//        if currentItem.cell==1{
//            let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first
//                as! TableViewCell1
//            
//            cell.mainLabel.text = currentItem.text
//            loadPokeImageFor(imageView: cell.mainImageView, name: currentItem.text)
//            return cell
//            
//        }else if currentItem.cell==2{
            let cell = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first
                as! TableViewCell2
            
            cell.mainLabel.text = currentItem.name
            loadPokeImageFor(imageView: cell.mainImageView, name: currentItem.name)
            
            return cell
            
//        }
//        else{
//            let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first
//                as! TableViewCell1
//            
//            cell.mainLabel.text = currentItem.text
//            loadPokeImageFor(imageView: cell.mainImageView, name: currentItem.text)
//            return cell
//            
//        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // let currentItem = arrayOfCellData[indexPath.row];
        
         return 140
//        if currentItem.cell==1{
//            return 100
//            
//        }else if currentItem.cell==2{
//            return 140
//            
//        }else{
//            return 100
//        }
        
    }
    
    func loadPokeImageFor(imageView: UIImageView, name: String){
        
        let urlString = "https://img.pokemondb.net/artwork/\(name).jpg"
        
        print("fetching: \(urlString)")
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error.debugDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
            }.resume()
    }
    
    func fetchNewData(){
    
        let url = "https://pokeapi.co/api/v1/pokedex/1/"

        PokeFetcher.fetch(url: url, completion: { (failed, message, pokes) in
        
            if let poks = pokes  {
               
                DispatchQueue.main.async {
                    self.arrayOfCellData = poks;
                    self.tableView.reloadData()
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.arrayOfCellData = [Poke(name: "mew"), Poke(name: "mewtwo")];
                    self.tableView.reloadData()
                }
                
            }
    
        });
    }

}


