import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';

class SearchUtils {
  static String? getWhereSearchString({Searchlike? searchLike, Search? searchEquals}) {
    String? whereString = "";
    
    if(searchEquals != null){
      whereString += searchEquals.getSearchString() ?? "";
    } 
    if(searchLike != null){
      String searchLikeWhere = searchLike.getSearchString() ?? "";
      whereString += whereString == "" ? searchLikeWhere : "AND " + searchLikeWhere;
    }
    return  whereString == "" ? null : whereString;
  }
  
  static List<String>? getWhereArguments({Searchlike? searchLike, Search? searchEquals}){
    List<String>? whereArgs = [];
    
    if(searchEquals != null){
      whereArgs.addAll(searchEquals.getWhereArgs() ?? []);
    } 
    if(searchLike != null){
      whereArgs.addAll(searchLike.getWhereArgs() ?? []);
    }
    

    return whereArgs.isEmpty ? null : whereArgs;
  }
}