enum MultipleSearchCriteria {AND, OR}

class Searchlike{
  
  Map<String, dynamic> fields = {};
  String SearchString = "";
  List<String> whereArgs = [];
  MultipleSearchCriteria multipleSearchCriteria = MultipleSearchCriteria.AND;

  Searchlike(Map<String, dynamic> fields, {MultipleSearchCriteria multipleSearchCriteria = MultipleSearchCriteria.AND}){

    this.fields = fields;
    bool shouldReturn = false;
    fields.entries.forEach((element) {
      String multipleSearchCriteriaString = multipleSearchCriteria.name;
      
      if (element.value is List){
        for (var i = 0; i < element.value.length; i++) {
          SearchString += " ${element.key} LIKE ? OR";
          whereArgs.add(element.value[i]);
        }
        SearchString = SearchString.substring(0, SearchString.length - 2);
        shouldReturn = true;
        return;
      }
      else{
        SearchString += "${multipleSearchCriteriaString} ${element.key} LIKE ? ";
        whereArgs.add(element.value);
      }
    }
    );
    if (shouldReturn){
      return;
    }
    if(multipleSearchCriteria == MultipleSearchCriteria.AND)
      SearchString = SearchString.substring(4);
    else if(multipleSearchCriteria == MultipleSearchCriteria.OR)
      SearchString = SearchString.substring(3);
    else
      throw Exception("MultipleSearchCriteria not implemented");
  }


  String? getSearchString(){
    if (this.SearchString == ''){
      return null;
    }
    return this.SearchString;
  }
  List<String>? getWhereArgs(){
    if (this.whereArgs.isEmpty){
      return null;
    }
    return this.whereArgs;
  }
}