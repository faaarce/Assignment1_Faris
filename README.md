# Transaction Manager

A Swift project for managing financial transactions. This project includes a `Transaction` struct and a `TransactionManager` class to handle adding, deleting, summarizing, and filtering transactions.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features

- **Add Transactions**: Add new transactions with details like amount, category, date, and name.
- **Delete Transactions**: Remove transactions by category.
- **Summary**: Get a summary of transactions by category.
- **Filter**: Filter transactions based on a specific category.
- **Total Calculation**: Calculate total income and expenses.

## Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/faaarce/Assignment1_Faris.git
   ```

2. **Open the project**
   Open the cloned repository in Xcode.

## Usage

Here is an example of how to use the `Transaction` and `TransactionManager`:

```swift
import Foundation

// Define a transaction
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

// Manage multiple transactions
class TransactionManager {
  var expenses = 0
  var income = 0
  var transactionName: String
  var transactions: [Transaction] = []
  var categoryList: Set<String> = []
 
  init(transactionName: String) {
    self.transactionName = transactionName
  }
  
  func addTransaction(_ transaction: Transaction) {
    categoryList.insert(transaction.category)
    let transaction = Transaction(amount: transaction.amount, category: transaction.category, date: transaction.date, name: transaction.name)
    transactions.append(transaction)
  }
  
  func totalTransaction() -> (Int, Int) {
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
  
  func filteredTransaction(_ category: String) -> [Transaction] {
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

// Example usage
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
```

## Tech Stack

- **Language**: Swift
- **IDE**: Xcode
- **Framework**: Cocoa (for macOS development)

## License

This project is licensed under the WTFPL License - see the [WTFPL](https://en.wikipedia.org/wiki/WTFPL) file for details.
