import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/Invoice.dart';
import 'package:saving_tools/Entities/User.dart';

class Mapper {

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

  static UserDTO UserToUserDTO(User user){
    return UserDTO(
      username: user.username!,
      email: user.email!
    );
  }
}