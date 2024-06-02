enum MultipleSearchCriteria {AND, OR}

class Searchlike{
  
  Map<String, String> fields = {};
  String SearchString = "";
  List<String> whereArgs = [];
  MultipleSearchCriteria multipleSearchCriteria = MultipleSearchCriteria.AND;
  Searchlike(Map<String, String> fields, {MultipleSearchCriteria multipleSearchCriteria = MultipleSearchCriteria.AND}){

    this.fields = fields;

    fields.entries.forEach((element) async {
      String multipleSearchCriteriaString = multipleSearchCriteria.name;
      SearchString += "${multipleSearchCriteriaString} ${element.key} LIKE ? ";
      whereArgs.add(element.value);
    });
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