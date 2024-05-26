class InvoiceDTO {
  String? invoice;
  String? date;
  double? amount;

  InvoiceDTO({this.invoice, this.date, this.amount});

  factory InvoiceDTO.fromJson(Map<String, dynamic> json) {
    return InvoiceDTO(
      invoice: json['invoice'],
      date: json['date'],
      amount: double.tryParse(json['amount']),
    );
  }
}