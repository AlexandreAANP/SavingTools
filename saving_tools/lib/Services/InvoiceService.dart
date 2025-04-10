import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Repositories/InvoiceRepository.dart';
import 'package:saving_tools/Repositories/ProfitMarginRepository.dart';
import 'package:saving_tools/Repositories/SearchTools/OrderBy.dart';
import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/Repositories/WhoIs.dart';
import 'package:saving_tools/Services/ProfiMarginService.dart';
import 'package:saving_tools/Services/UserService.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceType.dart';
import 'package:sqflite/sqflite.dart';


class InvoiceService {

  InvoiceRepository? _invoiceRepository;
  ProfitMarginService? _profitMarginService;

  static Database? database;
  InvoiceService._privateConstructor(Database databaseName) {
    _invoiceRepository = InvoiceRepository(databaseName);
    _profitMarginService = ProfitMarginService();
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

    String actualUsername =  await WhoIs.getActualUsername();
    UserDTO user = await UserService().getUser(actualUsername);
    Invoice invoice = Invoice(
      invoice: invoiceName,
      date: "${Date.day}/${Date.month}/${Date.year}",
      category: Category,
      type: Type.name,
      amount: Type == InvoiceTypeEnum.credit ? Amount : -Amount,
      user_id: user.id
    );
    await _invoiceRepository!.insertInvoice(invoice);
    await _profitMarginService!.incrementProfitMargin(invoice.amount!);


  }

  Future<Search> getSearchLikeWithActualUser({Search? search}) async {
    UserDTO actualUser = await UserService().getUser(await WhoIs.getActualUsername());
    if(search != null && search.fields!.isNotEmpty){
      search.fields!['user_id'] = actualUser.id.toString();
      search = Search(search.fields!);
    }
    else{
      search = Search({
        'user_id': actualUser.id.toString()
      });
    }
    return search;
  }

  Future<Map<String,dynamic>> ListAllSearch({Searchlike? searchlike,Search? search, int? limit, int? offset, OrderBy? orderBy}) async {
    Search searchEquals = await getSearchLikeWithActualUser(search: search);
    List<Invoice> invoice =  await _invoiceRepository!.getAllSearchedInvoices(searchLike: searchlike, searchEquals: searchEquals, limit: limit, offset: offset, order: orderBy);

    int total = await _invoiceRepository!.getTotalInvoices(searchLike: searchlike, searchEquals: searchEquals);
    List<InvoiceDTO> invoiceDTO = [];
    invoice.forEach((element) {
      invoiceDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return {"invoices": invoiceDTO.toList(), "total": total};
  }

  

  Future<Map<String,double>> getInvoicesPercentage({int? limit}) async {

    UserDTO actualUser = await UserService().getUser(await WhoIs.getActualUsername());
    Map<String, double> percentage = {};
    Map<String, double> invoices = await _invoiceRepository!.getExpensesByCategory(user_id: actualUser.id);

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

    Search searchEquals = await getSearchLikeWithActualUser();

    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(searchEquals: searchEquals, order: OrderBy(fields), limit: limit);
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
    Search searchEquals = await getSearchLikeWithActualUser(search: Search(search));
    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(
                                                          order: OrderBy(fields),
                                                          searchEquals: searchEquals,
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
    Search searchEquals = await getSearchLikeWithActualUser(search: Search(search));
    List<Invoice> invoices = await _invoiceRepository!.getAllSearchedInvoices(
                                                          order: OrderBy(fields),
                                                          searchEquals: searchEquals,
                                                          limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO.reversed.toList();
  }


  Future<List<InvoiceDTO>> ListAllInvoices({int? limit}) async{
    UserDTO actualUser = await UserService().getUser(await WhoIs.getActualUsername());
    List<Invoice> invoices = await _invoiceRepository!.getAllInvoices(limit: limit, user_id: actualUser.id);
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
    UserDTO actualUser = await UserService().getUser(await WhoIs.getActualUsername());
    for(Invoice i in await _invoiceRepository!.getAllInvoices(user_id: actualUser.id)){
      await _invoiceRepository!.deleteInvoice(i.id!);
    }
  }

  
}