import 'dart:ui';

import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/InvoiceType.dart';

class InvoiceColors{
  static const Color _creditDarkColor = const Color.fromARGB(255, 9, 102, 45);
  static const Color _debitDarkColor = const Color.fromARGB(255, 102, 9, 9);

  static const Color _creditLightColor = const Color.fromARGB(255, 192, 241, 208);
  static const Color _debitLightColor = const Color.fromARGB(255, 255, 204, 204);

  static Color GetCreditDarkColor () => _creditDarkColor;
  static Color GetDebitDarkColor () => _debitDarkColor;
  static Color GetCreditLightColor () => _creditLightColor;
  static Color GetDebitLightColor () => _debitLightColor;


  static Color GetDarkColor(InvoiceTypeEnum? type) {
    switch (type) {
      case InvoiceTypeEnum.credit:
        return _creditDarkColor;
      case InvoiceTypeEnum.debit:
        return _debitDarkColor;
      default:
        return _debitDarkColor;
    }
  }

  static Color GetLightColor(InvoiceTypeEnum? type) {
    switch (type) {
      case InvoiceTypeEnum.credit:
        return _creditLightColor;
      case InvoiceTypeEnum.debit:
        return _debitLightColor;
      default:
        return _debitLightColor;
    }
  }
}