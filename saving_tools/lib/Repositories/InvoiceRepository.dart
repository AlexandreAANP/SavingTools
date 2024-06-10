import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchUtils.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
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

  


  Future<List<Invoice>> getAllSearchedInvoices({Searchlike? searchLike, Search? searchEquals, bool searchEqualFirst = true, OrderBy? order, int? limit, int? offset}) async {

    String? whereString = SearchUtils.getWhereSearchString(searchLike: searchLike, searchEquals: searchEquals);
    
    List<String>? whereArgs = SearchUtils.getWhereArguments(searchLike: searchLike, searchEquals: searchEquals);
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      where: whereString,
      whereArgs: whereArgs,
      limit: limit,
      offset: offset,
      orderBy: order?.getOrderString()
      );

      return List.generate(invoicesMaps.length, (i) {
          return Invoice(
            id: invoicesMaps[i]['id'] as int,
            invoice: invoicesMaps[i]['invoice'] as String,
            date: invoicesMaps[i]['date'] as String,
            category: invoicesMaps[i]['category'] as String,
            type: invoicesMaps[i]['type'] as String,
            amount: invoicesMaps[i]['amount'] as double,
            user_id: invoicesMaps[i]['user_id'] as int
          );
    });

  }

  Future<int> getTotalInvoices({Searchlike? searchLike, Search? searchEquals, bool searchEqualFirst = true}) async {
    String? whereString = SearchUtils.getWhereSearchString(searchLike: searchLike, searchEquals: searchEquals);
    List<String>? whereArgs = SearchUtils.getWhereArguments(searchLike: searchLike, searchEquals: searchEquals);
    print(whereString);
    print(whereArgs);
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      where: whereString,
      whereArgs: whereArgs,
    );

    return invoicesMaps.length;
  }


  Future<Map<String,double>> getExpensesByCategory({int user_id = 0}) async {
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      columns: ['category', 'amount'],
      where: 'user_id = ? AND type = ?',
      whereArgs: [user_id, 'debit']
    );

    Map<String, double> expenses = {};
    double total = 0;
    invoicesMaps.forEach((element) {
      if(expenses.containsKey(element['category'] as String)){
        expenses[element['category'] as String] = expenses[element['category'] as String]! + (-1* (element['amount'] as double));
      }
      else{
        expenses[element['category'] as String] = -1 * (element['amount'] as double);
      }
    });

    return expenses;
  }

  Future<List<String>> getAllCategories() async{
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      columns: ['category'],
      distinct: true
    );

    return List.generate(invoicesMaps.length, (i) {
      return invoicesMaps[i]['category'] as String;
    });
  }



  Future<List<Invoice>> getAllDebitInvoices({int? limit}) async {
    // Query the table for all The invoice.
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      where: 'type = ?',
      whereArgs: ['debit'],
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
        user_id: invoicesMaps[i]['user_id'] as int
      );
    });

  }

  Future<List<Invoice>> getAllCreditInvoices({int? limit}) async {
    // Query the table for all The invoice.
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      where: 'type = ?',
      whereArgs: ['credit'],
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
        user_id: invoicesMaps[i]['user_id'] as int
      );
    });

  }


  Future<List<Invoice>> getInvoicesOrderedBy(OrderBy order, {int? limit = null}) async {    
    final List<Map<String, Object?>> invoicesMaps = await this.database.query(
      table,
      orderBy: order.toString(),
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
        user_id: invoicesMaps[i]['user_id'] as int
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
    user_id: invoicesMaps.first['user_id'] as int
  );

  }

  Future<List<Invoice>> getAllInvoices({int? limit, int? user_id}) async {

  // Query the table for all the invoice.
  final List<Map<String, Object?>> invoicesMaps = await this.database.query(table, limit: limit, where: 'user_id = ?', whereArgs: [user_id]);

  // Convert the list of each invoices's fields into a list of `invoices` objects.
  return [
    for (final {
          'id': id as int,
          'invoice': invoice as String,
          'date': date as String,
          'category': category as String,
          'type': type as String,
          'amount': amount as double,
          'user_id': user_id as int
          
        } in invoicesMaps)
      Invoice(id: id, invoice: invoice, date: date, category: category, type: type, amount: amount, user_id: user_id),
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