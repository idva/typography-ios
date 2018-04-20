//
//  FontPickerViewController.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 07.06.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit
import Foundation

struct FontFamily {
    let familyName: String
    let fonts: [String]
}

class FontPickerViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var fontSizeLabel: UILabel!

    var filterString = ""
    
    var fontFamilies = [FontFamily]()
    
    func createFontFamilies() -> [FontFamily] {
        var families = [FontFamily]()

        for fontFamilyName in UIFont.familyNames {
            var filteredFonts = UIFont.fontNames(forFamilyName: fontFamilyName)
            if self.filterString.count > 0 {
                filteredFonts = filteredFonts.filter{
                    $0.lowercased().range(of: self.filterString.lowercased()) != nil
                }
            }
            
            if filteredFonts.count > 0 {
                families.append(FontFamily(familyName: fontFamilyName, fonts: filteredFonts))
            }
        }
        return families;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fontFamilies = self.createFontFamilies()
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fontFamilies.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fontFamily = self.fontFamilies[section]
        return fontFamily.fonts.count
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  self.fontFamilies[section].familyName
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        let fontFamily = self.fontFamilies[indexPath.section]
        let fontName = fontFamily.fonts[indexPath.row]
            
        cell.textLabel!.text = fontName
        cell.textLabel!.font = UIFont(name: fontName, size: 25.0)
        cell.backgroundColor = UIColor.white
        return cell;
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray;
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterString = searchText
        self.fontFamilies = self.createFontFamilies()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
