class Invoice {
  final int? id;
  final String? invoice;
  final String? date;
  final String? category;
  final String? type;
  final double? amount;
  final int? user_id;

  const Invoice({
    int? this.id,
    required this.invoice,
    required this.date,
    required this.category,
    required this.type,
    required this.amount,
    required this.user_id,
  });


  Map<String, Object?> toMap() {
    return {
      'invoice': invoice,
      'date': date,
      'category': category,
      'type': type,
      'amount': amount,
      'user_id': user_id,
    };
  }

  static List<String> getFields() {
    return [
      'invoice',
      'date',
      'category',
      'type',
      'amount',
    ];
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    if (id != null) {
      return 'Invoice{id: $id, invoice: $invoice, date: $date, category: $category, type: $type, amount: $amount}';
    }
    return 'Invoice{invoice: $invoice, date: $date, category: $category, type: $type, amount: $amount}';
  }
}