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

        for fontFamilyName in UIFont.familyNames() {
            var filteredFonts = UIFont.fontNamesForFamilyName(fontFamilyName)
            if self.filterString.characters.count > 0 {
                filteredFonts = filteredFonts.filter{
                    $0.lowercaseString.rangeOfString(self.filterString.lowercaseString) != nil
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fontFamilies.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fontFamily = self.fontFamilies[section]
        return fontFamily.fonts.count
    }
   
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  self.fontFamilies[section].familyName
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        let fontFamily = self.fontFamilies[indexPath.section]
        let fontName = fontFamily.fonts[indexPath.row]
            
        cell.textLabel!.text = fontName
        cell.textLabel!.font = UIFont(name: fontName, size: 25.0)
        cell.backgroundColor = UIColor.whiteColor()
        return cell;
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGrayColor();
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterString = searchText
        self.fontFamilies = self.createFontFamilies()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
