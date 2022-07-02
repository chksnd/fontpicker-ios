//
//  FontPickerViewController.swift
//  FontPicker
//
//  Created by Aibek Mazhitov on 01.07.22.
//

import UIKit

protocol FontPickerViewControllerDelegate {
  func fontPickerViewController(_ viewController: FontPickerViewController, didSelectFont fontName: String)
  func fontPickerViewControllerDidCancel(_ viewController: FontPickerViewController)
}

public class FontPickerViewController: UIViewController {

  // MARK: - View attributes

  private lazy var cancelBarButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(handleTapBarButtonItemCancel)
    )
  }()

  private lazy var searchController: FontSearchController = {
    let controller = FontSearchController(searchResultsController: nil)
    controller.delegate = self
    controller.obscuresBackgroundDuringPresentation = false
    controller.hidesNavigationBarDuringPresentation = false
    controller.searchBar.delegate = self
    controller.searchBar.placeholder = "search.placeholder".localized()
    controller.searchBar.autocapitalizationType = .none
    return controller
  }()

  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.dataSource = self
    view.delegate = self
    view.register(TableCell.self, forCellReuseIdentifier: TableCell.reuseIdentifier)
    return view
  }()

  private lazy var emptyView: EmptyView = {
    let view = EmptyView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Logic attributes

  lazy var dataSource = DataSource(delegate: self)

  var delegate: FontPickerViewControllerDelegate?

  private var searchText: String? {
    didSet {
      refresh()
      scrollToTop()
      hideEmptyView()
    }
  }

  // MARK: - View Life Cycle

  public override func viewDidLoad() {
    super.viewDidLoad()

    setupNotifications()
    setupView()
    setupNavigationBar()
    setupSearchController()
    setupTableView()
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    searchController.dismiss(animated: true)
  }

  // MARK: - Setup

  private func setupNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  private func setupView() {
    view.backgroundColor = .systemBackground
  }

  private func setupNavigationBar() {
    title = "search.title".localized()
    navigationItem.leftBarButtonItem = cancelBarButtonItem
  }

  private func setupSearchController() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
    extendedLayoutIncludesOpaqueBars = true
  }

  private func setupTableView() {
    view.addSubview(tableView)

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }

  private func showEmptyView(with state: EmptyViewState) {
    guard emptyView.superview == nil else {
      return
    }

    emptyView.state = state
    view.addSubview(emptyView)

    NSLayoutConstraint.activate([
      emptyView.topAnchor.constraint(equalTo: view.topAnchor),
      emptyView.leftAnchor.constraint(equalTo: view.leftAnchor),
      emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      emptyView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }

  private func hideEmptyView() {
    emptyView.removeFromSuperview()
  }

  // MARK: - Actions

  @objc private func handleTapBarButtonItemCancel(_ sender: Any) {
    searchController.searchBar.resignFirstResponder()
    delegate?.fontPickerViewControllerDidCancel(self)
  }

  private func scrollToTop() {
    let contentOffset = CGPoint(x: 0, y: -tableView.safeAreaInsets.top)
    tableView.setContentOffset(contentOffset, animated: false)
  }

  // MARK: - Data

  private func setSearchText(_ text: String?) {
    searchText = text
  }

  @objc func refresh() {
    DispatchQueue.global().async {
      self.dataSource.searchFonts(query: self.searchText!)
    }
  }

  func reloadData() {
    tableView.reloadData()

    if let fontName = Configuration.shared.pickedFontName {
      if let idx = dataSource.fonts.firstIndex(of: fontName) {
        let indexPath = IndexPath(row: idx, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
    }
  }

  // MARK: - Notifications

  @objc func keyboardWillShowNotification(_ notification: Notification) {
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size,
          let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
          }

    let bottomInset = keyboardSize.height - view.safeAreaInsets.bottom
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: bottomInset, right: 0.0)

    UIView.animate(withDuration: duration) { [weak self] in
      self?.tableView.contentInset = contentInsets
      self?.tableView.scrollIndicatorInsets = contentInsets
    }
  }

  @objc func keyboardWillHideNotification(_ notification: Notification) {
    guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }

    UIView.animate(withDuration: duration) { [weak self] in
      self?.tableView.contentInset = .zero
      self?.tableView.scrollIndicatorInsets = .zero
    }
  }
}

// MARK: - UISearchBarDelegate

extension FontPickerViewController: UISearchBarDelegate {
}

// MARK: - UISearchControllerDelegate

extension FontPickerViewController: UISearchControllerDelegate {
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    setSearchText(searchText)
  }
}

// MARK: - DataSourceDelegate

extension FontPickerViewController: DataSourceDelegate {
  func dataSourceFontsLoaded(_ dataSource: DataSource) {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }

  func dataSource(_ dataSource: DataSource, didSearch fonts: [String]) {
    DispatchQueue.main.async {
      self.reloadData()

      if fonts.isEmpty {
        self.showEmptyView(with: .noResults)
      }
    }
  }
}

// MARK: - TableViewDelegate

extension FontPickerViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.fonts.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let fontName = dataSource.fonts[indexPath.row]

    let cell = TableCell(style: .subtitle, reuseIdentifier: TableCell.reuseIdentifier)
    cell.textLabel?.text = "cell.placeholder".localized()
    cell.textLabel?.font = UIFont.init(name: fontName, size: UIFont.labelFontSize)
    cell.detailTextLabel?.text = fontName

    return cell
  }
}

extension FontPickerViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let fontName = dataSource.fonts[indexPath.row]
    delegate?.fontPickerViewController(self, didSelectFont: fontName)
  }
}

