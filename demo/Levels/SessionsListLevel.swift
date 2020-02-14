import UIKit

class SessionsListLevel: VisionStackLevel, UITableViewDataSource, UITableViewDelegate {
    private enum Constants {
        static let tableHorizontalOffset: CGFloat = 150.0
        static let tableTopInset: CGFloat = 15.0
        static let labelTopInset: CGFloat = 30.0
    }
    private let replaySessionsManager: ReplaySessionManager
    private var selectedRow: Int = 0

    var callback: ((ReplaySession?) -> Void)?

    init(with replaySessionsManager: ReplaySessionManager) {
        self.replaySessionsManager = replaySessionsManager
        super.init()
        set(transparency: 0.5)
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Select source"
        title.font = title.font.withSize(18.0).bold()
        title.textColor = UIColor.white
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.labelTopInset),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        addSubview(table)
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.tableHorizontalOffset),
            table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.tableHorizontalOffset),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            table.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.tableTopInset)
        ])
        table.separatorInset = 0.0
        table.separatorColor = UIColor.white.withAlphaComponent(0.4)
        table.backgroundColor = UIColor.clear
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView()
        table.tintColor = UIColor.lightGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replaySessionsManager.sessions.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "tablecell")
        if let textLabel = cell.textLabel {
            if indexPath.row == 0 {
                textLabel.text = "Camera"
            } else {
                textLabel.text = replaySessionsManager.sessions[indexPath.row - 1].name
            }
            textLabel.font = textLabel.font.bold()
            textLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        }
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        cell.selectedBackgroundView = bgColorView
        cell.selectionStyle = .gray
        cell.backgroundColor = UIColor.clear
        if indexPath.row != 0, let detailLabel = cell.detailTextLabel {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY HH:mm"
            if let date = replaySessionsManager.sessions[indexPath.row - 1].creationDate {
                detailLabel.text = dateFormatter.string(from: date)
            }
            detailLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        }
        if selectedRow == indexPath.row {
            cell.accessoryType = .checkmark
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: IndexPath(row: selectedRow, section: 0))?.accessoryType = .none
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedRow = indexPath.row

        if indexPath.row == 0 {
            callback?(nil)
            return
        }

        let session = replaySessionsManager.sessions[indexPath.row - 1]
        callback?(session)
    }
}

private extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
