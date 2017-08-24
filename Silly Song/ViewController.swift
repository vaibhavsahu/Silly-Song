//
//  ViewController.swift
//  Silly Song
//
//  Created by Vaibhav Sahu on 8/10/17.
//  Copyright © 2017 Vaibhav Sahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var lyricsView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Called at Editing did Begin event
    //nameField and lyricsView shoult be set to empty string
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
        //disabling autocorrect as soon as user starts writing on textField
        nameField.autocorrectionType = .no
    }
    
    //Delegate method for nameField. This method would be called when users hit the return key in the text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //Called at Editing did End Event
    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }
    
    //The shortened name is all lowercase letters, to fit in with the song
    //Any consonants before the first vowel are removed. If no vowels exist in the string, then no consonants are removed.
    //example: vaibhav -> aibhav, vbhv -> vbhv
    func shortNameFromName(name: String) -> String{
        //rule 1, covert the name string to all lowercase letters
        
        //very interesting feature I just got to know
        let charSet = CharacterSet(charactersIn: "aeiou")
        
        //rule 2
        if let index = name.lowercased().rangeOfCharacter(from: charSet)?.lowerBound {
            return name.substring(from: index).lowercased()
        }
        
        return name.lowercased()
    }
    
    // The lyricsForName() method converts the lyrics template into the personalized lyrics by substituting the full and shortened versions of the specified name.
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(name: fullName)
        
        //I didn't find a better method replacing fullname and shortname in a single statement
        let lyrics =
            lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    
}

