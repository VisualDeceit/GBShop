//
//  NewReviewView.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.09.2021.
//

import UIKit

class AddReviewView: UIView {
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .cinnabar
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
         label.adjustsFontForContentSizeCategory = false
        label.font = UIFontMetrics.default.scaledFont(for: UIFont.captionParangon25)
        label.text = "Новый отзыв"
        return label
    }()

    private(set) lazy var captionTextField: UITextField = {
        let textFild = UITextField()
        textFild.translatesAutoresizingMaskIntoConstraints = false
        textFild.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFild.textColor = .label
        textFild.borderStyle = .none
        textFild.autocorrectionType = .no
        textFild.clearButtonMode = .whileEditing
        textFild.placeholder = "Заголовок"
        textFild.tintColor = UIColor.uaRed
        return textFild
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray4
        label.text = "Оценка"
        return label
    }()
    
    private(set) lazy var ratingSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["0", "1", "2", "3", "4", "5"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 5
        return control
    }()
    
    private(set) lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray4
        label.text = "Комментарий"
        return label
    }()
  
    private(set) lazy var commentTextView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .label
        textView.textAlignment = .justified
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blueSappire.cgColor
        textView.font = .systemFont(ofSize: 14)
        textView.autocorrectionType = .no
        textView.isScrollEnabled = true
        return textView
    }()
    
    private(set) lazy var postReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemBackground
        button.tintColor = UIColor.cinnabar
        button.setTitle("Добавить отзыв", for: .normal)
        button.accessibilityIdentifier = "addReviewButton"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        accessibilityIdentifier = "SignUpView"
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        addSubview(titleLabel)
        addSubview(captionTextField)
        addSubview(ratingLabel)
        addSubview(ratingSegmentedControl)
        addSubview(commentLabel)
        addSubview(commentTextView)
        addSubview(postReviewButton)
        setupConstrains()
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: readableContentGuide.topAnchor, constant: 16),
            
            captionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            captionTextField.heightAnchor.constraint(equalToConstant: 44),
            captionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            captionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: captionTextField.bottomAnchor, constant: 16),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            ratingSegmentedControl.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16),
            ratingSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ratingSegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            commentLabel.topAnchor.constraint(equalTo: ratingSegmentedControl.bottomAnchor, constant: 16),
            commentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            commentTextView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            commentTextView.bottomAnchor.constraint(equalTo: postReviewButton.topAnchor, constant: -16),

            postReviewButton.widthAnchor.constraint(equalToConstant: 200),
            postReviewButton.heightAnchor.constraint(equalToConstant: 44),
            postReviewButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            postReviewButton.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor, constant: -16)
        ])
    }
}
