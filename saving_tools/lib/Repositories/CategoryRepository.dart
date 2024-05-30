import 'package:shared_preferences/shared_preferences.dart';

class CategoryRepository{

  String categoryKey = "categories";

  Future<SharedPreferences>? prefs;

  CategoryRepository(){
    prefs = SharedPreferences.getInstance();
  }


  Future<void> addCategory(String category) async {
    List<String> categories = await getCategories();
    categories.remove(category);
    categories.add(category);
    await prefs!.then((value) => value.setStringList(categoryKey, categories));
  }

  Future<List<String>> getCategories() async {
    List<String> categories = [];
    await prefs!.then((value) => categories = value.getStringList(categoryKey) ?? []);
    return categories;
  }

  Future<void> deleteCategory(String category) async {
    List<String> categories = await getCategories();
    categories.remove(category);
    await prefs!.then((value) => value.setStringList(categoryKey, categories));
  }

}