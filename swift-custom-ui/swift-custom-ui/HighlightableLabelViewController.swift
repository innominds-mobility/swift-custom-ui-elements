//
//  HighlightableLabelViewController.swift
//  swift-custom-ui
//
//  Created by Tejasree Marthy on 14/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

class HighlightableLabelViewController: UIViewController {
    
    @IBOutlet weak var emailIDLabel: UILabel!
    @IBOutlet weak var phoneNumLbl: UILabel!
    // @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var urlBgView: UIView!
    
    var textContainer = NSTextContainer()
    var layoutManager = NSLayoutManager()
    var urlStr = NSString()
    var urlAttributedStr = NSMutableAttributedString()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Pass range and string to highlet text with color at particular range
        emailIDLabel.attributedText = self.highletLabelWithParticularAtParticularRange(inputStr:"This is my mailid abc@innominds.com", textRange: NSMakeRange(18,17))
        
        ///Static email text placed in label
        let emailStr : NSString = "This is a highletable text label with multiple mailids abc@innominds.com and another mailid test@gmail.com"
        emailLbl.attributedText = self.extractRequiredText(inputStr: emailStr,regExprsn: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        
        
        ///Static mobile text placed in label
        let phonsStr : NSString = "Adding specific color to mobile number 9912345678"
        
        phoneNumLbl.attributedText = self.extractRequiredText(inputStr: phonsStr , regExprsn: "[0-9]{10,10}")
        
        ///Static url text placed in label
        urlStr  = "Adding specific color to url1 http://innominds.com and url2 http://google.com"
        
        urlAttributedStr = self.extractRequiredText(inputStr: urlStr , regExprsn: "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?")
        self.tapOnUrlLink(localizedString: urlAttributedStr.string as NSString, typeOfWord: "http");
        
    }
    
    ///Method to place tapgesture over particular loaction
    func tapOnUrlLink(localizedString : NSString, typeOfWord : NSString) {
        
        ///Get the piece of code separated with #
        var localizedStringPieces: [String] = localizedString.components(separatedBy: "#")
        ///Loop through all the pieces:
        let msgChunkCount: Int = localizedStringPieces.count != 0 ? localizedStringPieces.count : 0
        var wordLocation = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
        
        
        for i in 0..<msgChunkCount {
            let chunk: String? = localizedStringPieces[i]
            if (chunk == "") {
                continue
                // skip this loop if the chunk is empty
            }
            
            
            //Determine what type of word this is:
            let isLink: Bool? = chunk?.hasPrefix(typeOfWord as String)
            
            //Create label, styling dependent on whether it's a link:
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: CGFloat(15.0))
            label.text = chunk
            label.isUserInteractionEnabled = true
            
            if isLink == true {
                
                label.textColor = UIColor(red: CGFloat(110 / 255.0), green: CGFloat(181 / 255.0), blue: CGFloat(229 / 255.0), alpha: CGFloat(1.0))
                label.highlightedTextColor = UIColor.yellow
                
                //Set tap gesture for this clickable text:
                let selectorAction: Selector = #selector(self.taponTheLink)
                let tapGesture = UITapGestureRecognizer(target: self, action: selectorAction)
                label.addGestureRecognizer(tapGesture)
                
                // Trim the markup characters from the label:
                if isLink! {
                    label.text = label.text?.replacingOccurrences(of: "#", with: "")
                }
            }
            else {
                label.textColor = UIColor.black
            }
            
            label.sizeToFit()
            
            if urlBgView.frame.size.width < wordLocation.x + label.bounds.size.width {
                wordLocation.x = 0.0
                // move this word all the way to the left...
                wordLocation.y += label.frame.size.height
                // ...on the next line
                // And trim of any leading white space:
                let startingWhiteSpaceRange: NSRange = (label.text! as NSString).range(of: "^\\s*", options: .regularExpression)
                if startingWhiteSpaceRange.location == 0 {
                    label.text = (label.text! as NSString).replacingCharacters(in: startingWhiteSpaceRange, with: "")
                    label.sizeToFit()
                }
            }
            
            // Set the location for this label:
            label.frame = CGRect(x: CGFloat(wordLocation.x), y: CGFloat(wordLocation.y), width: CGFloat(label.frame.size.width), height: CGFloat(label.frame.size.height))
            // Show this label:
            urlBgView.addSubview(label)
            
            wordLocation.x += label.frame.size.width
            
        }
        
    }
    
    //tapgesture method that fires on tapping link
    func taponTheLink (tapGesture: UITapGestureRecognizer) {
        if tapGesture.state == .ended {
            print("User tapped on the hyper link")
            let view: UIView? = tapGesture.view
            if (view is UILabel) {
                let lbl: UILabel? = (view as? UILabel)
                print("lbl.text = \(String(describing: lbl?.text))")
                let url = URL(string: (lbl?.text)!)
                let application = UIApplication.shared
                application.open(url!, options: [:], completionHandler: nil)
                
                
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Highlets label color with string and range
    ///Pass complete string and also range of string that requires color
    func highletLabelWithParticularAtParticularRange(inputStr: NSString, textRange: NSRange) -> NSMutableAttributedString{
        let mutableString = NSMutableAttributedString(string: inputStr as String, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13.0)])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: textRange)
        return mutableString
    }
    
    ///Highlets label color by passing substring from complete string
    func highletLabelSubSTring(inputStr: NSString) -> NSMutableAttributedString{
        let mutableString = NSMutableAttributedString(string: inputStr as String, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13.0)])
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, inputStr.length))
        return mutableString
    }
    
    
    ///Extract emailAddress/phone/url from given text and return as array
    func extractRequiredText(inputStr : NSString,regExprsn: NSString) -> NSMutableAttributedString{
        
        var results = [String]()
        do {
            let regExp = try NSRegularExpression(pattern: regExprsn as String, options: NSRegularExpression.Options.caseInsensitive)
            
            regExp.enumerateMatches(in: inputStr as String, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: inputStr.length), using: { (result: NSTextCheckingResult!, _, _) in
                results.append(inputStr.substring(with: result.range))
            })
            
            print(results)
        }
        catch _ {
        }
        
        if results.count != 0
        {
            let  mutableString  = NSMutableAttributedString.init(string: inputStr as String)
            for Str in results
            {
                //Adding color to extracted or required string
                mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.purple, range: inputStr.range(of: Str))
                if isValidUrl(slctdUrl: Str as NSString)
                {
                    mutableString.replaceCharacters(in: (mutableString.string as NSString).range(of: Str), with:String(format:"#%@#", Str))
                }
                
            }
            return mutableString
        }
        return NSMutableAttributedString.init(string: "")
    }
    
    
    //Checking the string is in valid url format like http/https://www.google.com
    
    func isValidUrl(slctdUrl : NSString) -> Bool {
        let urlRegEx: String = "(http|https|smb)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        
        return urlTest.evaluate(with: slctdUrl, substitutionVariables: nil)
    }
}
