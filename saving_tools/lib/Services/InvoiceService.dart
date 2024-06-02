import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Repositories/InvoiceRepository.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceType.dart';
import 'package:sqflite/sqflite.dart';


class InvoiceService {

  InvoiceRepository? _invoiceRepository;

  static Database? database;
  InvoiceService._privateConstructor(Database databaseName) {
    _invoiceRepository = InvoiceRepository(databaseName);
  }

  static final InvoiceService _instance = InvoiceService._privateConstructor(database!);

  factory InvoiceService() {

    return _instance;
  }


  Future<void> addInvoice({
    required String invoiceName,
    required DateTime Date,
    required String Category,
    required InvoiceTypeEnum Type,
    required double Amount
  }
  ) async {
    Invoice invoice = Invoice(
      invoice: invoiceName,
      date: "${Date.day}/${Date.month}/${Date.year}",
      category: Category,
      type: Type.name,
      amount: Type == InvoiceTypeEnum.credit ? Amount : -Amount
    );
    await _invoiceRepository!.insertInvoice(invoice);
    print("Invoice inserted");
  }


  Future<Map<String,dynamic>> ListAllSearch({Searchlike? searchlike, int? limit, int? offset, OrderBy? orderBy}) async {
    List<Invoice> invoice =  await _invoiceRepository!.getAllSearchedInvoices(searchLike: searchlike, limit: limit, offset: offset, order: orderBy);
    int total = await _invoiceRepository!.getTotalInvoices(searchLike: searchlike);
    List<InvoiceDTO> invoiceDTO = [];
    invoice.forEach((element) {
      invoiceDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return {"invoices": invoiceDTO.toList(), "total": total};
  }


  Future<Map<String,double>> getInvoicesPercentage({int? limit}) async {
    Map<String, double> percentage = {};
    Map<String, double> invoices = await _invoiceRepository!.getExpensesByCategory();
    double total = invoices.entries.fold(0, (previousValue, element) => previousValue + element.value);
    invoices.forEach((key, value) {
      percentage[key] = (value/total) * 100;
    });

    //get top 5 more expensive categories
    Map<String, double> top5 = {};
    for(String category in percentage.keys.toList()){
      if(top5.length < 5){
        top5[category] = percentage[category]!;
      }
      else{
        double min = top5.values.reduce((value, element) => value < element ? value : element);
        if(percentage[category]! > min){
          top5.remove(top5.keys.firstWhere((element) => top5[element] == min));
          top5[category] = percentage[category]!;
        }
      }
    }
    Map<String, double> others = {};
    for(String category in percentage.keys.toList()){
      if(!top5.containsKey(category)){
        if(!others.containsKey("Others")){
          others["Others"] = 0;
        }
        others["Others"] = percentage[category]!;
      }
    }
    if(others.containsKey("Others")){
      top5["Others"] = others["Others"]!;
    }
    return top5;
  }

  Future<List<InvoiceDTO>> ListInvoicesShortTableAllTypes() async {
    int limit = 5;
    Map<String, String> fields = {
      'date': 'DESC',
    };
    
    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(order: OrderBy(fields), limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO.reversed.toList();
  }

  Future<List<InvoiceDTO>> ListDebitInvoicesShortTableAllTypes() async {
    int limit = 5;
    Map<String, String> fields = {
      'date': 'DESC',
    };
    Map<String, String> search = {
      'type': 'debit',
    };
    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(
                                                          order: OrderBy(fields),
                                                          searchEquals: Search(search),
                                                          limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO.reversed.toList();
  }


  Future<List<InvoiceDTO>> ListCreditInvoicesShortTableAllTypes() async {
    int limit = 5;
    Map<String, String> fields = {
      'date': 'DESC',
    };
    Map<String, String> search = {
      'type': 'credit',
    };
    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(
                                                          order: OrderBy(fields),
                                                          searchEquals: Search(search),
                                                          limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO.reversed.toList();
  }


  Future<List<InvoiceDTO>> ListAllInvoices({int? limit}) async{
    List<Invoice> invoices = await _invoiceRepository!.getAllInvoices(limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO.reversed.toList();
  }


  Future<void> DeleteInvoice(int id) async {
    await _invoiceRepository!.deleteInvoice(id);
  }

  Future<void> DeleteAllInvoices() async {
    for(Invoice i in await _invoiceRepository!.getAllInvoices()){
      await _invoiceRepository!.deleteInvoice(i.id!);
    }
  }

  
}