class Search{


  Map<String, String>? fields;
  String SearchString = '';
  List<String> whereArgs = [];

  Search(Map<String, String> fields){
    this.fields = fields;

    fields.entries.forEach((element) async {
      SearchString += "AND ${element.key} = ? ";
      whereArgs.add(element.value);
    });
    SearchString = SearchString.substring(4);
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