//
//  CountryTableViewController.swift
//  iOSNetworking
//
//  Created by khavishini suresh on 14/06/2022.
//

import UIKit

class CountryTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let service = Service(baseUrl: "https://restcountries.com/v2/")
        service.getAllCountryNameFrom(endPoint: "all")
        service.completionHandler{ [weak self] (countries, status, message) in
            if status {
                guard let self = self else {return}
                guard let _countries = countries else {return}
                self.countries = _countries
                self.tableView.reloadData()
            }
        }
    }
    
    func searchCountry(for name: String) {
        let service = Service(baseUrl: "https://restcountries.com/v2/name/")
        service.getAllCountryNameSearched(endPoint: name)
        service.completionHandler{ [weak self] (countries, status, message) in
            if status {
                guard let self = self else {return}
                guard let _countries = countries else {return}
                self.countries = _countries
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name

        return cell
    }
}

extension CountryTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchbar: UISearchBar) {
        guard let countryName = searchBar.text
        else {
            return
        }
        searchCountry(for: countryName)
    }
}
