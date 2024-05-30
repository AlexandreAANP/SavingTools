import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/DTOs/Mapper.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Repositories/InvoiceRepository.dart';
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

  Future<List<InvoiceDTO>> ListInvoices({int? limit}) async {
    List<Invoice> invoices = await _invoiceRepository!.getAllInvoices(limit: limit);
    List<InvoiceDTO> invoicesDTO = [];
    invoices.forEach((element) {
      invoicesDTO.add(Mapper.InvoiceToInvoiceDTO(element));
    });
    return invoicesDTO;
  }


  Future<List<InvoiceDTO>> ListInvoicesShortTableAllTypes() async {
    int limit = 5;
    Map<String, String> fields = {
      'date': 'DESC',
    };
    List<Invoice> invoices = await _invoiceRepository!.getInvoicesOrderedBy(fields, limit: limit);
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