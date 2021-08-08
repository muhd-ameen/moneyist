class Transaction {
  int id;
  String title;
  String amount;
  String category;
  String transactionDate;


  transactionMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['amount'] = amount;
    mapping['category'] = category;
    mapping['transactionDate'] = transactionDate;

    return mapping;
  }
}
