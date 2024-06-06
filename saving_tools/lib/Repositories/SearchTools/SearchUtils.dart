import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';

class SearchUtils {
  static String? getWhereSearchString({Searchlike? searchLike, Search? searchEquals, required bool searchEqualFirst}) {
    String? whereString = "";
    if(searchEqualFirst){
      if(searchEquals != null){
        whereString += searchEquals.getSearchString() ?? "";
      } 
      else if(searchLike != null){
        whereString += searchLike.getSearchString() ?? "";
      }
      whereString = whereString == "" ? null : whereString;
    }
    else{
      if(searchLike != null){
        whereString += searchLike.getSearchString() ?? "";
      } 
      else if(searchEquals != null){
        whereString += searchEquals.getSearchString() ?? "";
      }
      whereString = whereString == "" ? null : whereString;
    }
    return whereString;
  }
  
  static List<String>? getWhereArguments({Searchlike? searchLike, Search? searchEquals, required bool searchEqualFirst}){
    List<String>? whereArgs = [];
    if(searchEqualFirst){
      if(searchEquals != null){
        whereArgs.addAll(searchEquals.getWhereArgs() ?? []);
      } 
      else if(searchLike != null){
        whereArgs.addAll(searchLike.getWhereArgs() ?? []);
      }
    }

    return whereArgs.isEmpty ? null : whereArgs;
  }
}