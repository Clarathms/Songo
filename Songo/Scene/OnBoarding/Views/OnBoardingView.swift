//
//  PageControllerView.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 21/06/21.
//

import UIKit
import AuthenticationServices

class OnBoardingView: UIView {
    var buttonsBottomSpacing = UIScreen.main.bounds.height * -0.05
    
    var skipButtonBottomConstraint: NSLayoutConstraint?
    var pageControlBottomConstraint: NSLayoutConstraint?
    var lastPageButtonsBottomConstraint: NSLayoutConstraint?
    
    let attrs: [NSAttributedString.Key: Any] = [
        .font: UIFont.callout,
        .foregroundColor: UIColor.fillMain,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var shouldShow: Bool = false {
        didSet {
            if oldValue != shouldShow {
                shouldShow ? showButton() : hideButton()
            }
        }
    }

    var pageView: UIView
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    var signInWithAppleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var lowerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(initialPage: Int, numberOfPages: Int, pageView: UIView) {
        self.pageView = pageView

        super.init(frame: .zero)
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = initialPage
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup
    func setupPageView() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageView)

        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: self.topAnchor),
            pageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10)
        ])
    }

    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        
        self.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func setupLowerButton() {
        self.addSubview(lowerButton)
        
        NSLayoutConstraint.activate([
            lowerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lowerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonsBottomSpacing),
            lowerButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("Pular", comment: "OnBoardingView: First variation of the lowerButton's name."), attributes: attrs)
        lowerButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func setupSignInWithAppleButton() {
        self.addSubview(signInWithAppleButton)
        
        NSLayoutConstraint.activate([
            signInWithAppleButton.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),
            signInWithAppleButton.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: lowerButton.topAnchor, constant: -15),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 50),
            signInWithAppleButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20)
        ])
        
        signInWithAppleButton.isHidden = true
    }

    func setupView() {
        self.backgroundColor = .white

        setupPageControl()
        setupPageView()
        setupLowerButton()
        setupSignInWithAppleButton()
    }
    
    func isNotFirstTime() {
        pageControl.isHidden = true
        signInWithAppleButton.isHidden = false
        shouldShow = true
    }
    
// MARK: - Private Functions
    private func showButton() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            self.signInWithAppleButton.isHidden = false
        }
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("Deixar para depois", comment: "OnBoardingView: Second variation of the lowerButton's name."), attributes: attrs)
        lowerButton.setAttributedTitle(attributedString, for: .normal)
    }

    private func hideButton() {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve) {
            self.signInWithAppleButton.isHidden = true
        }
        let attributedString = NSMutableAttributedString(string: NSLocalizedString("Pular", comment: "OnBoardingView: First variation of the lowerButton's name."), attributes: attrs)
        lowerButton.setAttributedTitle(attributedString, for: .normal)
    }
}
