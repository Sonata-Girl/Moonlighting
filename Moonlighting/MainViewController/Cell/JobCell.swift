//
//  JobCell.swift
//  Moonlighting
//
//  Created by Sonata Girl on 31.10.2023.
//

import UIKit

final class JobCell: UICollectionViewCell {
    
    // MARK: UIElements
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let jobNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let salaryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.lightCornerRadius
        view.backgroundColor = .appYellowColor()
        return view
    }()
    
    private let salaryLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.smallFont
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var employerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let employerLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.smallFont
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let dateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.lightCornerRadius
        view.backgroundColor = .gray
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.smallFont
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.lightCornerRadius
        view.backgroundColor = .gray
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.smallFont
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure view

private extension JobCell {
    func configureView() {
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.appYellowColor().cgColor
    }
}

// MARK: - Setup Hierarchy

private extension JobCell {
    func setupHierarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(separatorView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        topStackView.addArrangedSubview(jobNameLabel)
        topStackView.addArrangedSubview(salaryView)
        salaryView.addSubview(salaryLabel)
        
        bottomStackView.addArrangedSubview(employerImageView)
        bottomStackView.addArrangedSubview(employerLabel)
        bottomStackView.addArrangedSubview(dateView)
        bottomStackView.addArrangedSubview(timeView)
        
        dateView.addSubview(dateLabel)
        timeView.addSubview(timeLabel)
    }
}

// MARK: - Setup constraints

private extension JobCell {
    func setupLayout() {
        addSubview(mainStackView)
        subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Setup properties

extension JobCell {
    func configureCell(jobModel: JobModel) {
        jobNameLabel.text = jobModel.employer
        salaryLabel.text = String(jobModel.salary)
        if let dataImage = jobModel.logoData {
            employerImageView.image = UIImage(data: dataImage)
        }
        employerLabel.text = jobModel.employer
        dateLabel.text = jobModel.dateDay
        timeLabel.text = jobModel.dateTime
    }
    
    func changeStateOfCell(selected: Bool) {
        switch selected {
        case true :
            contentView.layer.borderWidth = 3
        case false :
            contentView.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        jobNameLabel.text = nil
        salaryLabel.text = nil
        employerLabel.text = nil
        dateLabel.text = nil
        timeLabel.text = nil
        contentView.layer.borderWidth = 0
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

    static var smallFont: UIFont = .systemFont(ofSize: 15)
    
}
