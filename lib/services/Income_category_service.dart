import 'package:moneyist/models/Incomecategory.dart';
import 'package:moneyist/repositories/repository.dart';

class IncomeCategoryService {
  Repository _repository;

  IncomeCategoryService() {
    _repository = Repository();
  }

  // Create data
  saveCategory(IncomeCategory incomeCategory) async {
    return await _repository.insertData('IncomeCategories', incomeCategory.IncategoryMap());
  }

  // Read data from table
  readCategories() async {
    return await _repository.readData('IncomeCategories');
  }

  // Read data from table by Id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('IncomeCategories', categoryId);
  }

  // Update data from table
  updateCategory(IncomeCategory incomeCategory) async {
    return await _repository.updateData('IncomeCategories', incomeCategory.IncategoryMap());
  }


  // Delete data from table
  deleteCategory(categoryId) async{
    return await _repository.deleteData('IncomeCategories', categoryId);
  }
}
