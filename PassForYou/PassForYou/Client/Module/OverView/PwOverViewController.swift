/*********************************************************************************
 * 版权所有,2017,lisir.
 * Copyright(C),lisir, LTD.All rights reserved.
 * project:
 * Author:lisir
 * Date:  17/05/27
 * QQ/Tel/Mail:383118832
 * Description:获取保存在本地的数据
 * Others:
 * Modifier:
 * Reason:
 **********************************************************************************/

import UIKit
import CoreData

class PwOverViewController: BaseTableViewController {
    private let reuseId = "password";
    private lazy var dataSource:[ Account ] = {
        if let list = Account.fetchNSManagedObject(className: Account.classForCoder(), sortKey: "id") as? [Account]{
            return list;
        }
        return Array<Account>();
    }()
    
    private var fetchController:NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "总览";
        configTableview();
        configAddButtonItem();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:CONFIG TABLEVIEW
    private func configTableview(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId);
        tableView.estimatedRowHeight = 88;
    }
    
    //MARK:config right item
    private func configAddButtonItem(){
    
        let right = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(rightAction));
        
        navigationItem.rightBarButtonItem = right;
    }
    //MARK:right action
    func rightAction(){
        let add = PwAddController();
        add.addBlock = {[unowned self](ac:Account)->Void in
            let newindex = IndexPath.init(row: self.dataSource.count, section: 0)
            self.dataSource.append(ac);
            self.tableView.beginUpdates();
            self.tableView.insertRows(at: [newindex], with: .automatic);
            self.tableView.endUpdates();
        }
        show(add, sender: nil);
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
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.attributedText = info.getComAttributed();
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = dataSource[indexPath.row];
        let detail = PwDetailController();
        detail.ac = ac;
        show(detail, sender: nil);
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;//支持编辑
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let del = UITableViewRowAction.init(style: .destructive, title: "删除") {[unowned self](action:UITableViewRowAction, newindex:IndexPath) in
            
            let ac = self.dataSource[newindex.row];
            
            Account.delete(object: ac);
            
            self.tableView.beginUpdates();
            
            self.dataSource.remove(at: newindex.row);
            
            self.tableView.deleteRows(at: [newindex], with: .automatic);
            
            self.tableView.endUpdates();
        }
        return [del];
    }
    
}
