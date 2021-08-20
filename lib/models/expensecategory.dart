class ExpenseCategory {
  int id;
  String exname;
  String exdescription;

  ExcategoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['exname'] = exname;
    mapping['exdescription'] = exdescription;

    return mapping;
  }
}
