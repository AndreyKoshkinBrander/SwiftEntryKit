//
//  EKMessageContentView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKMessageContentView: UIView {
    
    // MARK: Properties
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var horizontalConstraints: QLAxisConstraints!
    private var topConstraint: NSLayoutConstraint!
        
    public var titleContent: EKProperty.LabelContent! {
        didSet {
            titleLabel.content = titleContent
            titleLabel.isHidden = titleContent.text.isEmpty
        }
    }
    
    public var subtitleContent: EKProperty.LabelContent! {
        didSet {
            subtitleLabel.content = subtitleContent
            subtitleLabel.isHidden = subtitleContent.text.isEmpty
        }
    }
    
    public var titleAttributes: EKProperty.LabelStyle! {
        didSet {
            titleLabel.style = titleAttributes
        }
    }
    
    public var subtitleAttributes: EKProperty.LabelStyle! {
        didSet {
            subtitleLabel.style = subtitleAttributes
        }
    }
    
    public var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subtitle: String! {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    public var verticalMargins: CGFloat = 20 {
        didSet {
            topConstraint.constant = verticalMargins
            layoutIfNeeded()
        }
    }
    
    public var horizontalMargins: CGFloat = 20 {
        didSet {
            horizontalConstraints.first.constant = horizontalMargins
            horizontalConstraints.second.constant = -horizontalMargins
            layoutIfNeeded()
        }
    }
    
    public var labelsOffset: CGFloat = 8 {
        didSet {
            stackView.spacing = labelsOffset
            layoutIfNeeded()
        }
    }
    
    // MARK: Setup
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        clipsToBounds = true
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        addSubview(stackView)
        topConstraint = stackView.layoutToSuperview(.top,
                                                    relation: .greaterThanOrEqual,
                                                    offset: verticalMargins)
        horizontalConstraints = stackView.layoutToSuperview(axis: .horizontally, offset: horizontalMargins)
        stackView.layoutToSuperview(.centerY)
        
        stackView.spacing = labelsOffset
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.forceContentWrap(.vertically)
    }
    
    private func setupSubtitleLabel() {
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.forceContentWrap(.vertically)
    }
    
    private func setupInterfaceStyle() {
        titleLabel.textColor = titleContent?.style.color(for: traitCollection)
        subtitleLabel.textColor = subtitleContent?.style.color(for: traitCollection)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupInterfaceStyle()
    }
}
