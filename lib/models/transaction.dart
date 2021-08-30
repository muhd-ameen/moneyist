
class Transaction {
  int id;
  String title;
  int amount;
  String category;
  String transactionDate;
  String memoImage;



  transactionMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['amount'] = amount;
    mapping['category'] = category;
    mapping['memoImage'] = memoImage;
    mapping['transactionDate'] = transactionDate;

    return mapping;
  }
}
