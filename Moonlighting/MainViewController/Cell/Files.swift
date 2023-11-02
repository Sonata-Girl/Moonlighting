////
////  Files.swift
////  Moonlighting
////
////  Created by Sonata Girl on 01.11.2023.
////
//
//import Foundation
////
////  JobCell.swift
////  Moonlighting
////
////  Created by Sonata Girl on 31.10.2023.
////
//
//import UIKit
//
//final class JobCell: UICollectionViewCell {
//    
//    // MARK: UIElements
//    
//    private let mainStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.backgroundColor = .red
//        stackView.distribution = .fillEqually
//        stackView.layer.cornerRadius = Constants.mediumCornerRadius
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private let topStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .green
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private let jobNameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 20, weight: .semibold)
//        label.textColor = .label
//        label.textAlignment = .left
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let salaryView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = Constants.lightCornerRadius
//        view.backgroundColor = .appYellowColor()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let salaryLabel: UILabel = {
//        let label = UILabel()
//        label.font = Constants.smallFont
//        label.textColor = .label
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let separatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let bottomStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .blue
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private var employerImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .lightGray
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = Constants.mediumCornerRadius
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let employerLabel: UILabel = {
//        let label = UILabel()
//        label.font = Constants.smallFont
//        label.textColor = .label
//        label.textAlignment = .left
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let dateTimeStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .blue
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private let dateView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = Constants.lightCornerRadius
//        view.backgroundColor = .gray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = Constants.smallFont
//        label.textColor = .label
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let timeView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = Constants.lightCornerRadius
//        view.backgroundColor = .gray
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = Constants.smallFont
//        label.textColor = .label
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    // MARK: Init
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupHierarchy()
//        setupLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Configure view
//
//private extension JobCell {
//    func configureView() {
//        contentView.layer.cornerRadius = 12
//        contentView.layer.borderColor = UIColor.appYellowColor().cgColor
//    }
//}
//
//// MARK: - Setup Hierarchy
//
//private extension JobCell {
//    func setupHierarchy() {
//        addSubview(mainStackView)
//        mainStackView.addArrangedSubview(topStackView)
//        mainStackView.addArrangedSubview(separatorView)
//        mainStackView.addArrangedSubview(bottomStackView)
//        
//        topStackView.addArrangedSubview(jobNameLabel)
//        topStackView.addArrangedSubview(salaryView)
//        salaryView.addSubview(salaryLabel)
//        
//        bottomStackView.addArrangedSubview(employerImageView)
//        bottomStackView.addArrangedSubview(employerLabel)
//        bottomStackView.addArrangedSubview(dateTimeStackView)
//        dateTimeStackView.addArrangedSubview(dateView)
//        dateTimeStackView.addArrangedSubview(timeView)
//        
//        dateView.addSubview(dateLabel)
//        timeView.addSubview(timeLabel)
//    }
//}
//
//// MARK: - Setup constraints
//
//private extension JobCell {
//    func setupLayout() {
////        subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false }
//        
//        NSLayoutConstraint.activate([
//            employerLabel.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: Constants.spacingItems),
//            employerLabel.leftAnchor.constraint(equalTo: topStackView.leftAnchor, constant: Constants.spacingItems),
//            topStackView.rightAnchor.constraint(equalTo: employerLabel.rightAnchor, constant: Constants.spacingItems),
//            topStackView.bottomAnchor.constraint(equalTo: employerLabel.bottomAnchor, constant: Constants.spacingItems),
//        ])
//        
//        NSLayoutConstraint.activate([
//            mainStackView.topAnchor.constraint(equalTo: topAnchor),
//            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            mainStackView.leftAnchor.constraint(equalTo: leftAnchor),
//            mainStackView.rightAnchor.constraint(equalTo: rightAnchor)
//        ])
//        
//        NSLayoutConstraint.activate([
//            topStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: Constants.indentFromSuperView),
//            mainStackView.rightAnchor.constraint(equalTo: topStackView.rightAnchor, constant: Constants.indentFromSuperView),
//            topStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.5)
//        ])
////
//        NSLayoutConstraint.activate([
//            separatorView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: Constants.indentFromSuperView),
//            mainStackView.rightAnchor.constraint(equalTo: separatorView.rightAnchor, constant: Constants.indentFromSuperView),
//            separatorView.heightAnchor.constraint(equalToConstant: 1),
//        ])
////
//        NSLayoutConstraint.activate([
//            bottomStackView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: Constants.indentFromSuperView),
//            mainStackView.rightAnchor.constraint(equalTo: bottomStackView.rightAnchor, constant: Constants.indentFromSuperView),
//        ])
////
//        NSLayoutConstraint.activate([
//            salaryView.topAnchor.constraint(equalTo: topStackView.topAnchor, constant: Constants.spacingItems),
////            salaryView.leftAnchor.constraint(equalTo: topStackView.leftAnchor, constant: Constants.indentFromSuperView),
//            topStackView.rightAnchor.constraint(equalTo: salaryView.rightAnchor, constant: Constants.indentFromSuperView),
//            topStackView.bottomAnchor.constraint(equalTo: salaryView.bottomAnchor, constant: Constants.indentFromSuperView),
//        ])
////
//        NSLayoutConstraint.activate([
//            salaryLabel.topAnchor.constraint(equalTo: salaryView.topAnchor),
//            salaryLabel.leftAnchor.constraint(equalTo: salaryView.leftAnchor),
//            salaryLabel.rightAnchor.constraint(equalTo: salaryView.rightAnchor),
//            salaryLabel.bottomAnchor.constraint(equalTo: salaryView.bottomAnchor),
//        ])
////
//////
//        
//        NSLayoutConstraint.activate([
//            employerImageView.topAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: Constants.spacingItems),
//            bottomStackView.bottomAnchor.constraint(equalTo: employerImageView.bottomAnchor, constant: Constants.spacingItems),
//            employerImageView.heightAnchor.constraint(equalToConstant: 35),
//            employerImageView.widthAnchor.constraint(equalToConstant: 35),
//        ])
//    }
//}
//
//// MARK: - Setup properties
//
//extension JobCell {
//    func configureCell(jobModel: JobModel) {
//        jobNameLabel.text = jobModel.profession
//        salaryLabel.text = String(jobModel.salary)
//        employerLabel.text = jobModel.employer
//        dateLabel.text = jobModel.dateDay
//        timeLabel.text = jobModel.dateTime
//        
//        if let urlLogo = jobModel.logo {
//            URLSession.shared.dataTask(with: urlLogo) { [weak self] data, _, error in
//                guard let data = data, error == nil else { return }
//                DispatchQueue.main.async {
//                    self?.employerImageView.image = UIImage(data: data)
//                }
//            }.resume()
//        }
//    }
//    
//    func changeStateOfCell(selected: Bool) {
//        switch selected {
//        case true :
//            contentView.layer.borderWidth = 3
//        case false :
//            contentView.layer.borderWidth = 0
//        }
//    }
//    
//    override func prepareForReuse() {
//        jobNameLabel.text = nil
//        salaryLabel.text = nil
//        employerLabel.text = nil
//        dateLabel.text = nil
//        timeLabel.text = nil
//        contentView.layer.borderWidth = 0
//    }
//}
//
//// MARK: - Identifier cell
//
//extension JobCell {
//    static var identifier: String {
//        String(describing: self)
//    }
//}
//
//// MARK: - Constants
//
//private enum Constants {
//    static var lightCornerRadius: CGFloat = 6
//    static var mediumCornerRadius: CGFloat = 15
//
//    static var smallFont: UIFont = .systemFont(ofSize: 15)
//    
//    static var indentFromSuperView: CGFloat = 20
//    static var offsetImage: CGFloat = 10
//    static var spacingItems: CGFloat = 10
//}
