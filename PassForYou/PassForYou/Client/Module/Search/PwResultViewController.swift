/*********************************************************************************
 * 版权所有,2021,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  2021/11/10
 * QQ/Tel/Mail:
 * Description:搜索
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

protocol PwResultViewControllerDelegate: NSObjectProtocol {
    func  resultsControllerDidSelect(_ account: Account)
}

class PwResultViewController: UITableViewController {

    private let mCellReuse = "results_account"
    private var mResults: Array<Account>?
    weak var delegate: PwResultViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK: 外部方法
    func setData(_ array: Array<Account>?){
        mResults = array
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let result = mResults, result.count > 0 else { return 0 }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = mResults else { return 0 }
        return result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mCellReuse, for: indexPath)
        if let account = mResults?[indexPath.row] {
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.attributedText = account.getComAttributed();
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let account = mResults?[indexPath.row] {
            delegate?.resultsControllerDidSelect(account)
        }
    }

}
//MARK: 私有方法
private extension PwResultViewController {
    /// 设置table view 的基础配置
    func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: mCellReuse)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
    }
}
