import 'package:moneyist/models/expensecategory.dart';
import 'package:moneyist/repositories/repository.dart';

class ExpenseCategoryService {
  Repository _repository;

  ExpenseCategoryService() {
    _repository = Repository();
  }

  // Create data
  saveCategory(ExpenseCategory expenseCategory) async {
    return await _repository.insertData('ExpenseCategories', expenseCategory.ExcategoryMap());
  }

  // Read data from table
  readCategories() async {
    return await _repository.readData('ExpenseCategories');
  }

  // Read data from table by Id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('ExpenseCategories', categoryId);
  }

  // Update data from table
  updateCategory(ExpenseCategory expenseCategory) async {
    return await _repository.updateData('ExpenseCategories', expenseCategory.ExcategoryMap());
  }


  // Delete data from table
  deleteCategory(categoryId) async{
    return await _repository.deleteData('ExpenseCategories', categoryId);
  }
}
