import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_moneyist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    // Expense Category

    await database.execute(
        "CREATE TABLE ExpenseCategories(id INTEGER PRIMARY KEY, exname STRING, exdescription STRING)");

    await database.execute(
        "INSERT Into ExpenseCategories (exname) VALUES ('Bills'), ('Food'), ('Travel'), ('Shopping'), ('Education');");


    // INcome Category

    await database.execute(
        "CREATE TABLE IncomeCategories(id INTEGER PRIMARY KEY, inname STRING, indescription STRING)");
    await database.execute(
        "INSERT Into IncomeCategories (inname) VALUES ('Salary'), ('Reward'),('Rental'),('Refund'),('Coupons');");



    // Create table todos
    await database.execute(
        "CREATE TABLE transactions(id INTEGER PRIMARY KEY, title VARCHAR(22), amount STRING, category TEXT, transactionDate TEXT, memoImage String)");
  }
}
