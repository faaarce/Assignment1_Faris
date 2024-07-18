import Cocoa

struct Transaction {
  var amount: Int
  var category: String
  var date: Date
  var name: String
  var description: String {
    """
    LIST
    transaction name: \(name)
    -----------------------
    category: \(category)
    -----------------------
    price: \(amount)
    """
  }
  
}

class TransactionManager {
  var expenses = 0
  var income = 0
  
  var transactionName: String
  var transactions: [Transaction] = []
  var categoryList: Set<String> = []
 
 
  init(transactionName: String) {
    self.transactionName = transactionName
  }
  
  func addTransaction(_ transaction: Transaction)  {
    categoryList.insert(transaction.category)
    let transaction = Transaction(amount: transaction.amount, category: transaction.category, date: transaction.date, name: transaction.name)
    transactions.append(transaction)
  }
  
  func totalTransaction() -> (Int, Int){
    for transaction in transactions {
      if transaction.amount >= 0 {
        income += transaction.amount
      } else {
        expenses += transaction.amount
      }
    }
    return (expenses, income)
  }
  
  func summaryTransaction() -> [String: Int] {
    var summary = [String: Int]()
    for transaction in transactions {
      
      if let amount = summary[transaction.category] {
        summary[transaction.category] = amount + transaction.amount
      } else {
        summary[transaction.category] = transaction.amount
      }
    }
    return summary
  }
  
  func filteredTransaction(_ category: String) ->[Transaction] {
     transactions.filter { transaction in
      print(transaction.category)
      return transaction.category == category
    }
  }
  
  func deleteTransaction(_ category: String) {
      let beforeCount = transactions.count
      transactions.removeAll { $0.category == category }
     
  }

  
}


var faris = TransactionManager(transactionName: "Faris")
faris.addTransaction(Transaction(amount: 100, category: "Income", date: .now, name: "Penghasilan Kerja"))
faris.addTransaction(Transaction(amount: -50, category: "Food", date: .now, name: "Makan Siang"))
faris.addTransaction(Transaction(amount: -80, category: "Shop", date: .now, name: "Baterai"))
faris.addTransaction(Transaction(amount: -80, category: "Shop", date: .now, name: "Kursi"))

faris.deleteTransaction("Shop")

print("AFTER DELETE")
for transaction in faris.transactions {
    print(transaction.description)
}
