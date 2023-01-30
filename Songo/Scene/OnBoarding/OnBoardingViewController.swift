//
//  OnBoardingViewController.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 21/06/21.
//

import UIKit

class OnBoardingViewController: BaseViewController<OnBoardingView> {

    let model: OnBoardingModel
    let pageViewController: OnBoardingPageViewController
    let onBoardingView: OnBoardingView
    
    let isFirstTime: Bool
    
    //MARK: -Injected Propertires
    typealias Factory = TabBarControllerSceneFactory
    
    let factory: Factory
    let authenticationController: AuthenticationController
    
    init(model: OnBoardingModel, factory: Factory, authenticationController: AuthenticationController, isFirstTime: Bool) {
        self.isFirstTime = isFirstTime
        
        self.model = model
        
        // If this is not the first time the user is seen the OnBoarding, we only want him to see the last page.
        // In order for that to happen, we remove all other pages from the array.
        if !isFirstTime {
            let lastPage = model.onBoardingItems.count - 1
            model.onBoardingItems = [model.onBoardingItems[lastPage]]
        }
        
        self.pageViewController = OnBoardingPageViewController(model: model)
        self.onBoardingView = OnBoardingView(initialPage: model.currentPage, numberOfPages: model.onBoardingItems.count, pageView: pageViewController.view)
        self.factory = factory
        self.authenticationController = authenticationController
        super.init(mainView: onBoardingView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.delegate = self
        setupButtonAction()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        if !isFirstTime {
            mainView.isNotFirstTime()
        }
    }
    
    func setupButtonAction() {
        // Add actions to buttons.
        onBoardingView.pageControl.addTarget(self, action: #selector(pageControlWasTapped), for: .valueChanged)
        onBoardingView.lowerButton.addTarget(self, action: #selector(lowerButtonWasTapped), for: .touchUpInside)
        onBoardingView.signInWithAppleButton.addTarget(self, action: #selector(signInWithAppleButtonWasTapped), for: .touchUpInside)
    }
}
// MARK: - Actions.
extension OnBoardingViewController {
    @objc
    func pageControlWasTapped(_ sender: UIPageControl) {
        pageViewController.setViewControllers([pageViewController.pagesArray[sender.currentPage]], direction: .forward, animated: true, completion: nil)

        animateButtonsBackAndForth()
    }

    @objc
    func lowerButtonWasTapped() {
        if !isFirstTime {
            self.dismiss(animated: true, completion: nil)
            
        } else {
            UserDefaults.standard.set(true, forKey: "SEEN-ONBOARDING")
            let isCurrentPageLast = onBoardingView.pageControl.currentPage == pageViewController.pagesArray.count - 1
            
            switch isCurrentPageLast {
            case true:
                self.navigationController?.setViewControllers([factory.createTabBarControllerScene()], animated: true)
            case false:
                let lastPage = pageViewController.pagesArray.count - 1
                onBoardingView.pageControl.currentPage = lastPage

                pageViewController.setViewControllers([pageViewController.pagesArray[lastPage]], direction: .forward, animated: true, completion: nil)
                animateButtonsBackAndForth()
            }
        }
    }
    
    @objc
    func signInWithAppleButtonWasTapped() {
        UserDefaults.standard.set(true, forKey: "SEEN-ONBOARDING")
        authenticationController.performSignIn() { error in
            if let error = error {
                switch error {
                case .signInCanceled:
                    // If the user cenceled the signIn operation, just do nothing
                    return
                case .missingUserInformation:
                    self.present(self.authenticationController.userMissingInformationAlert, animated: true)
                default:
                    self.present(self.authenticationController.signInFailed, animated: true)
                }
            } else {
                if !self.isFirstTime {
                    // If it is a modal, dismiss it
                    self.dismiss(animated: true)
                } else {
                    // If it is the first time you are accessing the app, segue to the tabBarScene
                    self.navigationController?.setViewControllers([self.factory.createTabBarControllerScene()], animated: true)
                }
            }
        }
    }
}
// MARK: - Delegate.
extension OnBoardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentViewController = viewControllers[0] as? OnBoardingItemViewController else { return }
        guard let currentIndex = self.pageViewController.pagesArray.firstIndex(of: currentViewController) else { return }

        onBoardingView.pageControl.currentPage = currentIndex
        animateButtonsBackAndForth()
    }

    func animateButtonsBackAndForth() {
        let isCurrentPageLast = onBoardingView.pageControl.currentPage == pageViewController.pagesArray.count - 1
        onBoardingView.shouldShow = isCurrentPageLast
    }
}
