//
//  JobCell.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

final class JobCell: UICollectionViewCell {
    
    // MARK: UI elements

    private let mainView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = Constants.mediumCornerRadius
        return stackView
    }()

    // MARK: Top subview
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let jobNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 20,
            weight: .medium
        )
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let salaryLabel: UILabel = {
        let label = PaddingLabel(
            insets: .init(
                top: 0,
                left: 5,
                bottom: 0,
                right: 5)
        )
        label.textColor = .label
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.backgroundColor = .appYellowColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constants.lightCornerRadius
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGrayColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

   // MARK: Bottom subview

    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let employerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.appLightGrayColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.mediumCornerRadius
        imageView.image = UIImage(named: "noLogo")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .appLightGrayColor()
        return imageView
    }()
    
    private let employerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let dateLabel: UILabel = {
        let label = PaddingLabel(
            insets: .init(
                top: 0,
                left: 3,
                bottom: 0,
                right: 3)
        )
        label.textColor = .label
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.backgroundColor = .appLightGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constants.lightCornerRadius
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = PaddingLabel(
            insets: .init(
                top: 0,
                left: 3,
                bottom: 0,
                right: 3)
        )
        label.textColor = .label
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.backgroundColor = .appLightGrayColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constants.lightCornerRadius
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        additionSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure view

private extension JobCell {
    func configureView() {
        backgroundColor = .white
        layer.cornerRadius = Constants.mediumCornerRadius
    }
    
    func setDefaultStateCell() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.appLightGrayColor().cgColor
    }
}

// MARK: - Setup Hierarchy

private extension JobCell {
    func additionSubviews() {
        addSubview(mainView)
        mainView.addSubview(topView)
        mainView.addSubview(separatorView)
        mainView.addSubview(bottomView)

        topView.addSubview(jobNameLabel)
        topView.addSubview(salaryLabel)

        bottomView.addSubview(employerImageView)
        
        bottomView.addSubview(employerLabel)
        bottomView.addSubview(dateTimeStackView)
        dateTimeStackView.addArrangedSubview(dateLabel)
        dateTimeStackView.addArrangedSubview(timeLabel)
    }
}

// MARK: - Setup constraints

private extension JobCell {
    func setupLayout() {
        let quarterSizeWidthCell = bounds.width/3.8
       
        // MARK: Main stack constraints
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leftAnchor.constraint(
                equalTo: leftAnchor,
                constant: Constants.indentFromSuperView
            ),
            rightAnchor.constraint(
                equalTo: mainView.rightAnchor,
                constant: Constants.indentFromSuperView
            ),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // MARK: Top subview constraints
       
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: mainView.topAnchor),
            topView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: topView.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: Constants.heightOfCellParts)
         ])
        
        NSLayoutConstraint.activate([
            jobNameLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            jobNameLabel.leftAnchor.constraint(equalTo: topView.leftAnchor),
            jobNameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
        ])

         NSLayoutConstraint.activate([
            salaryLabel.topAnchor.constraint(
                equalTo: topView.topAnchor,
                constant: Constants.mediumSpacingItems
            ),
            salaryLabel.leftAnchor.constraint(equalTo: jobNameLabel.rightAnchor),
            salaryLabel.rightAnchor.constraint(equalTo: topView.rightAnchor),
            topView.bottomAnchor.constraint(
                equalTo: salaryLabel.bottomAnchor,
                constant: Constants.mediumSpacingItems
            ),
            salaryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10)
        ])
        salaryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        salaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // MARK: Separator constraints
       
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: separatorView.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])

        // MARK: Bottom subview constraints
       
        NSLayoutConstraint.activate([
            bottomView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: bottomView.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: Constants.heightOfCellParts)
        ])
        
        NSLayoutConstraint.activate([
            employerImageView.topAnchor.constraint(
                equalTo: bottomView.topAnchor,
                constant: Constants.smallSpacingItems
            ),
            employerImageView.leftAnchor.constraint(equalTo: bottomView.leftAnchor),
            bottomView.bottomAnchor.constraint(
                equalTo: employerImageView.bottomAnchor,
                constant: Constants.smallSpacingItems
            ),
            employerImageView.widthAnchor.constraint(equalToConstant: 32),
        ])
        
        NSLayoutConstraint.activate([
            employerLabel.topAnchor.constraint(
                equalTo: bottomView.topAnchor,
                constant: Constants.mediumSpacingItems
            ),
            employerLabel.leftAnchor.constraint(
                equalTo: employerImageView.rightAnchor,
                constant: Constants.mediumSpacingItems
            ),
            bottomView.bottomAnchor.constraint(
                equalTo: employerLabel.bottomAnchor,
                constant: Constants.mediumSpacingItems
            ),
        ])
        
        NSLayoutConstraint.activate([
            dateTimeStackView.topAnchor.constraint(
                equalTo: bottomView.topAnchor,
                constant: Constants.mediumSpacingItems
            ),
            dateTimeStackView.rightAnchor.constraint(equalTo: bottomView.rightAnchor),
            bottomView.bottomAnchor.constraint(
                equalTo: dateTimeStackView.bottomAnchor,
                constant: Constants.mediumSpacingItems
            ),
            dateTimeStackView.leftAnchor.constraint(
                equalTo: employerLabel.rightAnchor,
                constant: Constants.mediumSpacingItems
            ),
            dateTimeStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: quarterSizeWidthCell)
        ])
        
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        timeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    }
}

// MARK: - Configure cell values

extension JobCell {
    func configureCell(jobModel: JobModel) {
        jobNameLabel.text = jobModel.profession
        salaryLabel.text = "\(String(format: "%.2f", jobModel.salary)) \(Constants.rubSymbol)"
        employerLabel.text = jobModel.employer
        dateLabel.text = jobModel.dateDay
        timeLabel.text = jobModel.dateTime

        if let logoData = jobModel.logoData {
            employerImageView.image = UIImage(data: logoData)
        }
        changeStateOfCell(selected: jobModel.isSelected)
    }

    func changeStateOfCell(selected: Bool) {
        isSelected = selected
        switch selected {
        case true :
            layer.borderColor = UIColor.appYellowColor().cgColor
            layer.borderWidth = 2
        case false :
            setDefaultStateCell()
        }
    }

    override func prepareForReuse() {
        jobNameLabel.text = nil
        salaryLabel.text = nil
        employerLabel.text = nil
        dateLabel.text = nil
        timeLabel.text = nil
        employerImageView.image = nil
        setDefaultStateCell()
    }
}

// MARK: - Identifier cell

extension JobCell {
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Constants

private enum Constants {
    static var lightCornerRadius: CGFloat = 6
    static var mediumCornerRadius: CGFloat = 15
    
    static var indentFromSuperView: CGFloat = 20
    static var mediumSpacingItems: CGFloat = 15
    static var smallSpacingItems: CGFloat = 10
    
    static var heightOfCellParts: CGFloat = 52
    
    static var smallFont: UIFont = .systemFont(ofSize: 15)
    static var rubSymbol = "₽"
}
