import UIKit
import SnapKit


class OnboardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    private lazy var onboardingViewControllers: [UIViewController] = {
        let firstVC = ZeroViewController()
        let secondVC = FirstViewController()
        let thirdVC = SecondViewController()
        return [firstVC, secondVC, thirdVC]
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    
    private lazy var rectView: UIView = {
       let view = UIView()
        view.layer.opacity = 0.98
        view.layer.cornerRadius = 12
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingViewControllers.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var textFast: UILabel = {
        let text = UILabel()
        text.text = "Fast shipping"
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return text
    }()
    
    private lazy var textDesired: UILabel = {
        let text = UILabel()
        text.text = "Get all of your desired sneakers in one place."
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 17)
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "SEEN-TUTORIAL")
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([onboardingViewControllers[0]], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        view.addSubview(rectView)
        view.addSubview(textFast)
        view.addSubview(textDesired)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        setupConstraints()
    }
    
    func setupConstraints() {
        rectView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(288)
            make.bottom.equalToSuperview()
        }
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(58)
            make.height.equalTo(54)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(248)
            make.centerX.equalToSuperview()
        }
        textFast.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        textDesired.snp.makeConstraints { make in
            make.top.equalTo(textFast.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func nextButtonTapped() {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let currentIndex = onboardingViewControllers.firstIndex(of: currentViewController) else {
            return
        }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < onboardingViewControllers.count {
            let nextViewController = onboardingViewControllers[nextIndex]
            pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = nextIndex
            
            if nextIndex == onboardingViewControllers.count - 1 {
                nextButton.setTitle("Finish", for: .normal)
                nextButton.addTarget(self, action: #selector(goToVC), for: .touchUpInside)
                nextButton.removeTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                nextButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
            }
        } else {
            finishOnboarding()
        }
    }
    @objc func goToVC() {
       
    }
    @objc private func finishButtonTapped() {
        finishOnboarding()
        let vc = LoginViewController()
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)    }
    
    private func finishOnboarding() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return onboardingViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.firstIndex(of: viewController), index < onboardingViewControllers.count - 1 else {
            return nil
        }
        return onboardingViewControllers[index + 1]
    }
}
