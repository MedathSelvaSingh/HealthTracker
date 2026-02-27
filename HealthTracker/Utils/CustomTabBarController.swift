//
//  CustomTabBarController.swift
//  HealthTracker
//
//  Created by Yahweh Nissi on 25/02/26.
//

import UIKit

class CustomTabBarController: UITabBarController {

    private let customTabBarView = UIView()
    private var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupCustomTabBar()
        addPanGestureToTabBar()
    }

    private func setupViewControllers() {
        
        let vc1 = UINavigationController(rootViewController: DashboardVC())
        vc1.view.backgroundColor = .systemBackground
        let vc2 = UINavigationController(rootViewController: AddMetricsVC())
        vc2.view.backgroundColor = .systemBackground
        let vc3 = UINavigationController(rootViewController: ViewMetricsVC())
        vc3.view.backgroundColor = .systemBackground
        
        self.viewControllers = [vc1, vc2, vc3]
    }

    private func setupCustomTabBar() {
        tabBar.isHidden = true
        
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 35
        customTabBarView.layer.shadowColor = UIColor.black.cgColor
        customTabBarView.layer.shadowOpacity = 0.1
        customTabBarView.layer.shadowOffset = CGSize(width: 0, height: 4)
        customTabBarView.layer.shadowRadius = 10
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(customTabBarView)
        NSLayoutConstraint.activate([
            customTabBarView.heightAnchor.constraint(equalToConstant: 70),
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        let icons:[UIImage] = [.homeUnselected,.addUnslected,.viewunselected]
        let iconSelected:[UIImage] = [.homeSelected,.addSelected,.viewSelected]
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        customTabBarView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: customTabBarView.centerYAnchor)
        ])

        for (index, iconName) in icons.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = index
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            let image = iconName
            button.setImage(image, for: .normal)
            button.setImage(iconSelected[index], for: .selected)
            button.tintColor = index == 0 ? UIColor.orange : UIColor.systemOrange.withAlphaComponent(0.5)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFit
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        animateSelection(index: 0)
    }

    @objc private func tabButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedIndex = index
        animateSelection(index: index)
        triggerHapticFeedback()
    }
    
     func animateSelection(index: Int) {
        for (i, button) in buttons.enumerated() {
            button.isSelected = (i == index)
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: [],
                           animations: {
                button.transform = button.isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
            }, completion: nil)
        }
    }
    
    func setCustomTabBarHidden(_ hidden: Bool, animated: Bool = false) {
        let duration: TimeInterval = animated ? 0.25 : 0
        UIView.animate(withDuration: duration) {
            self.customTabBarView.alpha = hidden ? 0 : 1
        }
    }

    private func addPanGestureToTabBar() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTabBarSwipe(_:)))
        customTabBarView.addGestureRecognizer(panGesture)
    }

    @objc private func handleTabBarSwipe(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: customTabBarView)
        
        if gesture.state == .ended {
            if abs(velocity.x) > abs(velocity.y) {
                if velocity.x < 0 {
                    // Swipe left
                    if selectedIndex < (buttons.count - 1) {
                        selectedIndex += 1
                        animateSelection(index: selectedIndex)
                        triggerHapticFeedback()
                    }
                } else {
                    // Swipe right
                    if selectedIndex > 0 {
                        selectedIndex -= 1
                        animateSelection(index: selectedIndex)
                        triggerHapticFeedback()
                    }
                }
            }
        }
    }

    private func triggerHapticFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
