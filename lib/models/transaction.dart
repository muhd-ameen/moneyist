import 'package:intl/intl.dart';

class Transaction {
  int id;
  String title;
  String amount;
  String category;
  String transactionDate;
  DateTime _dateTime = DateTime.now();

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
