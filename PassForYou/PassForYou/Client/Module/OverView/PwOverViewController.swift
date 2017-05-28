/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:
 * Description:获取保存在本地的数据
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit

class PwOverViewController: BaseTableViewController {
    private let reuseId = "password";
    private lazy var dataSource:[ Account ] = {
        if let list = Account.fetchNSManagedObject(className: Account.classForCoder(), sortKey: "id") as? [Account]{
            return list;
        }
        return Array<Account>();
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "总览";
        configTableview();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:CONFIG TABLEVIEW
    private func configTableview(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId);
        let key = UIApplication.shared.keyWindow!
        let temp = PwActionView();
        key.addSubview(temp);
        temp.snp.makeConstraints { (make) in
            make.width.height.equalTo(100);
            make.bottom.equalToSuperview().offset(-64);
            make.right.equalToSuperview().offset(-22);
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let info = dataSource[indexPath.row];
        cell.textLabel?.text = info.id;
        return cell
    }
    
}
