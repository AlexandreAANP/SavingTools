

class Goal {
  int? id;
  String? description;
  String? date;
  double? percent;
  double? amount;
  int? rank;
  double? distributionPercentage;
  bool? isCompleted;
  bool? isExpired;
  int userId = 0; 

  Goal({
    this.id,
    this.description,
    this.date,
    this.percent,
    this.amount,
    this.rank,
    this.distributionPercentage,
    this.isCompleted,
    this.isExpired,
    this.userId = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date,
      'percent': percent,
      'amount': amount,
      'rank': rank,
      'distributionPercentage': distributionPercentage,
      'isCompleted': isCompleted,
      'isExpired': isExpired,
      'user_id': userId
    };
  }

  Goal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    date = map['date'];
    percent = map['percent'];
    amount = map['amount'];
    rank = map['rank'];
    distributionPercentage = map['distributionPercentage'];
    isCompleted = map['isCompleted'];
    isExpired = map['isExpired'];
    userId = map['userId'];
  }
}