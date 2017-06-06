//
//  CustomTextField.swift
//  swift-custom-ui
//
//  Created by Aruna Kumari Yarra on 06/06/17.
//  Copyright © 2017 Innominds Mobility. All rights reserved.
//

import UIKit

@IBDesignable public class CustomTextField: UITextField {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var isLTRLanguage = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        didSet {
            self.updateTextAligment()
        }
    }
    fileprivate func updateTextAligment() {
        if self.isLTRLanguage {
            self.textAlignment = .left
        } else {
            self.textAlignment = .right
        }
        self.contentVerticalAlignment = .bottom
    }
    // MARK: Animation timing
    /// The value of the title appearing duration
    open var titleFadeInDuration: TimeInterval = 0.2
    /// The value of the title disappearing duration
    open var titleFadeOutDuration: TimeInterval = 0.3
    // MARK: Colors
    fileprivate var cachedTextColor: UIColor?
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override open var textColor: UIColor? {
        set {
            self.cachedTextColor = newValue
            self.updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable open var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            self.updatePlaceholder()
        }
    }
    fileprivate func updatePlaceholder() {
        if let
            placeholder = self.placeholder,
            let font = self.font {
            self.attributedPlaceholder =
                NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName:
                    placeholderColor, NSFontAttributeName: font])
        }
    }
    /// A UIColor value that determines the text color of the title label when in the normal state
    @IBInspectable open var titleColor: UIColor = UIColor.gray {
        didSet {
            self.updateTitleColor()
        }
    }
    /// A UIColor value that determines the color of the bottom line when in the normal state
    @IBInspectable open var lineColor: UIColor = UIColor.lightGray {
        didSet {
            self.updateLineView()
        }
    }
    /// A UIColor value that determines the text color of the title label when editing
    @IBInspectable open var selectedTitleColor: UIColor = UIColor.blue {
        didSet {
            self.updateTitleColor()
        }
    }
    /// A UIColor value that determines the color of the line in a selected state
    @IBInspectable open var selectedLineColor: UIColor = UIColor.black {
        didSet {
            self.updateLineView()
        }
    }
    /// A UIColor value that determines the color of the cursor (Blinking line while editing)
    @IBInspectable open var cursorColor: UIColor = UIColor.black {
        didSet {
            self.tintColor = cursorColor
        }
    }
    // MARK: Line height
    /// A CGFloat value that determines the height for the bottom line when the control is in the normal state
    @IBInspectable open var lineHeight: CGFloat = 0.5 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    /// A CGFloat value that determines the height for the bottom line when the control is in a selected state
    @IBInspectable open var selectedLineHeight: CGFloat = 1.0 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    // MARK: View components
    /// The internal `UIView` to display the line below the text input.
    open var borderLayer = CALayer()
    /// The internal `UILabel` that displays the selected, deselected title based on the current state.
    open var titleLabel: UILabel!
    // MARK: Properties
    /// The formatter to use before displaying content in the title label. This can be the `title`, `selectedTitle`.
    /// The default implementation converts the text to uppercase.
    open var titleFormatter: ((String) -> String) = { (text: String) -> String in
        return text.uppercased()
    }
    /// The backing property for the highlighted property
    fileprivate var _highlighted = false
    /// A Boolean value that determines whether the receiver is highlighted. 
    /// When changing this value, highlighting will be done with animation
    override open var isHighlighted: Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            self.updateTitleColor()
            self.updateLineView()
        }
    }
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    open var editingOrSelected: Bool {
        get {
            return super.isEditing || self.isSelected
        }
    }
    /// The text content of the textfield
    @IBInspectable override open var text: String? {
        didSet {
            self.updateControl(false)
        }
    }
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable override open var placeholder: String? {
        didSet {
            self.setNeedsDisplay()
            self.updatePlaceholder()
            self.updateTitleLabel()
        }
    }
    /// The String to display when the textfield is editing and the input is not empty.
    @IBInspectable open var selectedTitle: String? {
        didSet {
            self.updateControl()
        }
    }
    /// The String to display when the textfield is not editing and the input is not empty.
    @IBInspectable open var title: String? {
        didSet {
            self.updateControl()
        }
    }
    /// Determines whether the field is selected. When selected, the title floats above the textbox.
    open override var isSelected: Bool {
        didSet {
            self.updateControl(true)
        }
    }
    // MARK: - Initializers
    /// Initializes the control
    ///
    /// - Parameter frame: frame of the control
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.init_CustomTextField()
    }
    /// Intialzies the control by deserializing it
    ///
    /// - parameter coder the object to deserialize the control from
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.init_CustomTextField()
    }
    fileprivate final func init_CustomTextField() {
        self.borderStyle = .none
        self.createTitleLabel()
        self.createLineView()
        self.updateColors()
        self.addEditingChangedObserver()
        self.updateTextAligment()
    }
    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(CustomTextField.editingChanged), for: .editingChanged)
    }
    /// Invoked when the editing state of the textfield changes. Override to respond to this change.
    open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
    }
    // MARK: create components
    fileprivate func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = UIFont.init(name: (self.font?.fontName)!, size: 10)
        titleLabel.alpha = 0.0
        titleLabel.textColor = self.titleColor
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    fileprivate func createLineView() {
        borderLayer.borderColor = lineColor.cgColor
        borderLayer.frame = CGRect(origin: CGPoint(x: 0, y: (self.frame.size.height-lineHeight)),
                                   size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        borderLayer.borderWidth = lineHeight
        self.layer.addSublayer(borderLayer)
        self.layer.masksToBounds = true
    }
    fileprivate func configureDefaultLineHeight() {
        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
        self.lineHeight = 2.0 * onePixel
        self.selectedLineHeight = 2.0 * self.lineHeight
    }
    // MARK: Responder handling
    /// Attempt the control to become the first responder
    ///
    /// - Returns: True when successfull becoming the first responder
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.updateControl(true)
        return result
    }
    /// Attempt the control to resign being the first responder
    ///
    /// - Returns: True when successfull resigning being the first responder
    override open func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.updateControl(true)
        return result
    }
    // MARK: - View updates
    fileprivate func updateControl(_ animated: Bool = false) {
        self.updateColors()
        self.updateLineView()
        self.updateTitleLabel(animated)
    }
    /// updates lineview of textfield
    fileprivate func updateLineView() {
        if self.editingOrSelected {
            borderLayer.frame = CGRect(origin: CGPoint(x: 0, y: (self.frame.size.height-selectedLineHeight)),
                                       size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
            borderLayer.borderWidth = selectedLineHeight
        } else {
            borderLayer.frame = CGRect(origin: CGPoint(x: 0, y: (self.frame.size.height-lineHeight)),
                                       size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
            borderLayer.borderWidth = lineHeight
        }
        self.updateLineColor()
    }
    /// updates title of text field
    ///
    /// - Parameter animated: animaiton needed or not
    fileprivate func updateTitleLabel(_ animated: Bool = false) {
        var titleText: String? = nil
        if self.editingOrSelected {
            titleText = self.selectedTitleOrTitlePlaceholder()
            if titleText == nil {
                titleText = self.titleOrPlaceholder()
            }
        } else {
            titleText = self.titleOrPlaceholder()
        }
        self.titleLabel.text = titleText
        self.updateTitleVisibility(animated)
    }
    /// Returns whether the title is being displayed on the control.
    ///
    /// - Returns: True if the title is displayed on the control, false otherwise.
    open func isTitleVisible() -> Bool {
        return self.hasText
    }
    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: (() -> (Void))? = nil) {
        let alpha: CGFloat = self.isTitleVisible() ? 1.0 : 0.0
        let frame: CGRect = self.titleLabelRectForBounds(self.bounds, editing: self.isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            let animationOptions: UIViewAnimationOptions = .curveEaseOut
            let duration = self.isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
            }, completion: { _ in
                completion?()
            })
        } else {
            updateBlock()
            completion?()
        }
    }
    // MARK: - Color updates
    /// Update the colors for the control. Override to customize colors.
    open func updateColors() {
        self.updateLineColor()
        self.updateTitleColor()
        self.updateTextColor()
    }
    fileprivate func updateLineColor() {
        borderLayer.borderColor = self.editingOrSelected ? self.selectedLineColor.cgColor : self.lineColor.cgColor
    }
    fileprivate func updateTitleColor() {
        if self.editingOrSelected || self.isHighlighted {
            self.titleLabel.textColor = self.selectedTitleColor
        } else {
            self.titleLabel.textColor = self.titleColor
        }
    }
    fileprivate func updateTextColor() {
        super.textColor = self.cachedTextColor
    }
    // MARK: - Helpers
    fileprivate func titleOrPlaceholder() -> String? {
        if let title = self.title ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
    fileprivate func selectedTitleOrTitlePlaceholder() -> String? {
        if let title = self.selectedTitle ?? self.title ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
    // MARK: - Positioning Overrides
    /// Calculate the bounds for the title label. Override to create a custom size title field.
    ///
    /// - Parameters:
    ///   - bounds: The current bounds of the title
    ///   - editing: rue if the control is selected or highlighted
    /// - Returns: The rectangle that the title label should render in
    private func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
    private func titleHeight() -> CGFloat {
        return 15.0
    }
}
