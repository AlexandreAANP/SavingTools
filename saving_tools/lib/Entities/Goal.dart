

class Goal {
  int? id;
  String? description;
  String? date;
  double? percent;
  bool? isCompleted;
  bool? isExpired;
  int userId = 0; 

  Goal({this.id, this.description, this.date, this.percent, this.isCompleted, this.isExpired, this.userId = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date,
      'percent': percent,

    };
  }

  Goal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    date = map['date'];
    percent = map['percent'];
    isCompleted = map['isCompleted'];
    isExpired = map['isExpired'];
    userId = map['userId'];
  }
}