import 'package:moneyist/models/transaction.dart';
import 'package:moneyist/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  // create todos
  saveTodo(Transaction transaction) async {
    return await _repository.insertData('transactions', transaction.transactionMap());
  }

  // read todos
  readTodos() async {
    return await _repository.readData('transactions');
  }

  updateTodos(Transaction transaction) async {
    return await _repository.updateData('transactions', transaction.transactionMap());
  }

  // Delete data from table
  deleteTodos(transactionId) async{
    return await _repository.deleteData('transactions', transactionId);
  }


  // read todos by category
  readTodosByCategory(category) async {
    return await _repository.readDataByColumnName(
        'transactions', 'category', category);
  }
}
