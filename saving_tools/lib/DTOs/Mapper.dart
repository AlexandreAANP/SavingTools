import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/Entities/Invoice.dart';

class Mapper {
  // R get<T, R>(){

  // }


  static InvoiceDTO InvoiceToInvoiceDTO(Invoice invoice){
    return InvoiceDTO(
      id: invoice.id,
      invoice: invoice.invoice,
      date: invoice.date,
      category: invoice.category,
      type: invoice.type,
      amount: invoice.amount
    );
  }
}