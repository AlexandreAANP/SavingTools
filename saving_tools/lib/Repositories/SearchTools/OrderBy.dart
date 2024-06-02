class OrderBy{

  Map<String, String> fields = {};
  String orderString = '';

  OrderBy(Map<String, String> fields){
    this.fields = fields;
    this.orderString = this.generateOrderString(this.fields);
  }

  String generateOrderString(Map<String,String> fields){
    String order = "";
    fields.entries.forEach((element) async {
        order += ",${element.key} ${element.value}";
    });
    return order.substring(1);
  }


  String? getOrderString(){
    if (this.orderString == ''){
      return null;
    }
    return this.orderString;
  }
}