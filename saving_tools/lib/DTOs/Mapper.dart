import 'package:saving_tools/DTOs/GoalDTO.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/DTOs/UserDTO.dart';
import 'package:saving_tools/Entities/Goal.dart';
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
      id: user.id!,
      username: user.username!,
      email: user.email!
    );
  }

  static GoalDTO GoalToGoalDTO(Goal goal){
    String percentText = ((goal.percent ?? 0.0) * 100).toStringAsFixed(2) + "%";
    return GoalDTO(
      id: goal.id!,	
      description: goal.description!,
      date: goal.date!,
      percent: goal.percent ?? 0.0,
      percentText: percentText,
      amount: goal.amount ?? 0.0,
      isCompleted: goal.isCompleted ?? false,
      isExpired: goal.isExpired ?? false
    );
  }
}