class IncomeCategory {
  int id;
  String inname;
  String indescription;

  IncategoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['inname'] = inname;
    mapping['indescription'] = indescription;

    return mapping;
  }
}
