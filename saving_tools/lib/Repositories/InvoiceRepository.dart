import 'package:saving_tools/Entities/Invoice.dart';
import 'package:sqflite/sqflite.dart';

class InvoiceRepository{

  Database database;

  final String table = 'Invoice';

  InvoiceRepository(this.database);


  Future<void> insertInvoice(Invoice invoice) async {

  await this.database.insert(
    table,
    invoice.toMap(),
    conflictAlgorithm: ConflictAlgorithm.fail,
  );

  }

  


  Future<List<Invoice>> getInvoicesOrderedBy(Map<String, String> fields, {int? limit = null}) async {
    String order = "";
    fields.entries.forEach((element) async {
        order += ",${element.key} ${element.value}";
    });
    order = order.substring(1);
    // Query the table for all The invoice.
    
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      orderBy: order,
      limit: limit);
    // Convert the List<Map<String, Object?>> into a List<invoice>.
    return List.generate(invoicesMaps.length, (i) {
      return Invoice(
        id: invoicesMaps[i]['id'] as int,
        invoice: invoicesMaps[i]['invoice'] as String,
        date: invoicesMaps[i]['date'] as String,
        category: invoicesMaps[i]['category'] as String,
        type: invoicesMaps[i]['type'] as String,
        amount: invoicesMaps[i]['amount'] as double,
      );
    });

  }

  Future<Invoice> getInvoice(int id) async {
  
  final List<Map<String, Object?>> invoicesMaps = await this.database.query(
    table,
    where: 'id = ?',
    whereArgs: [id],
  );

  return Invoice(
    id: invoicesMaps.first['id'] as int,
    invoice: invoicesMaps.first['invoice'] as String,
    date: invoicesMaps.first['date'] as String,
    category: invoicesMaps.first['category'] as String,
    type: invoicesMaps.first['type'] as String,
    amount: invoicesMaps.first['amount'] as double,
  );

  }

  Future<List<Invoice>> getAllInvoices({int? limit}) async {

  // Query the table for all the invoice.
  final List<Map<String, Object?>> invoicesMaps = await this.database.query(table, limit: limit);

  // Convert the list of each invoices's fields into a list of `invoices` objects.
  return [
    for (final {
          'id': id as int,
          'invoice': invoice as String,
          'date': date as String,
          'category': category as String,
          'type': type as String,
          'amount': amount as double,
          
        } in invoicesMaps)
      Invoice(id: id, invoice: invoice, date: date, category: category, type: type, amount: amount),
  ];
}

Future<void> updateInvoice(Invoice invoice) async {


  // Update the given Dog.
  await this.database.update(
    table,
    invoice.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the invoice's id as a whereArg to prevent SQL injection.
    whereArgs: [invoice.id],
  );
}


Future<void> deleteInvoice(int id) async {
  // Remove the invoice from the database.
  await this.database.delete(
    table,
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}



}