import 'package:fl_chart/fl_chart.dart';
import 'package:saving_tools/DTOs/InvoiceDTO.dart';
import 'package:saving_tools/Repositories/SearchTools/Search.dart';
import 'package:saving_tools/Repositories/SearchTools/SearchLike.dart';
import 'package:saving_tools/Services/InvoiceService.dart';

class StatisticsService {

 InvoiceService? _invoiceService;
 StatisticsService(){
    _invoiceService = InvoiceService();
  
 }

 Future<List<double>> getMonthReview(int month, int year) async {
      
      Search search = Search({"type": "debit"});
      Searchlike searchLike = Searchlike({"date": "%/${month.toString()}/${year.toString()}"});
      
      List<InvoiceDTO> debitInvoices = (await _invoiceService!.ListAllSearch(searchlike: searchLike, search: search))["invoices"];
      double debitTotalAmount = 0;
      
      for (InvoiceDTO invoice in debitInvoices) {
        debitTotalAmount += invoice.amount ?? 0;
      }

      search = Search({"type": "credit"});
      searchLike = Searchlike({"date": "%/${month.toString()}/${year.toString()}"});

      List<InvoiceDTO> creditInvoices = (await _invoiceService!.ListAllSearch(searchlike: searchLike, search: search))["invoices"];
      double creditTotalAmount = 0;

      for (InvoiceDTO invoice in creditInvoices) {

        creditTotalAmount += invoice.amount ?? 0;
      }
      return [debitTotalAmount, creditTotalAmount];
 }

 Future<double> getMaxAmount({required int initialMonth, required int finalMonth, required int year}) async {



      List<String> dates = [];
      for (int i = initialMonth; i <= finalMonth; i++) {
        dates.add("%/${i.toString()}/${year.toString()}");
      }
      Searchlike searchLike = Searchlike({
        "date": dates,});
      List<InvoiceDTO> debitInvoices = (await _invoiceService!.ListAllSearch(searchlike: searchLike))["invoices"];

      double maxAmount = 0;
      for (InvoiceDTO invoice in debitInvoices) {
        if(invoice.amount! < 0){
          invoice.amount = -invoice.amount!;
        }
        if(invoice.amount! > maxAmount){
          maxAmount = invoice.amount!;
        }
      }
      return maxAmount;
 }

 Future<List<FlSpot>> getDebitData({required DateTime initialMonth, required DateTime finalMonth, double? maxValue}) async {
    List<String> dates = [];
    List<int> monthsIndex = [];
      for (int i = initialMonth.month; i <= finalMonth.month; i++) {
        int yearIncrementer = initialMonth.month + (i - initialMonth.month) > 12 ? 1 : 0;
        dates.add("%/${i.toString()}/${initialMonth.year + yearIncrementer}");
        monthsIndex.add(i);
      }
    List<FlSpot> data = [];
    List<double> daysAmount = List<double>.filled(90, 0.0);
    for (String date in dates){
      Searchlike searchLike = Searchlike({
        "date": date,});

      List<InvoiceDTO> invocies = (await _invoiceService!.ListAllSearch(searchlike: searchLike, search: Search({"type": "debit"})))["invoices"];
    
      
      for (int i = 0; i < invocies.length; i++) {
        int day = int.tryParse(invocies[i].date!.split("/")[0]) ?? 0;
        int month = int.tryParse(invocies[i].date!.split("/")[1]) ?? 0;

        int dayInScale = day + (monthsIndex.indexOf(month) * 30);
        if(dayInScale < daysAmount.length)
          daysAmount[dayInScale] += -invocies[i].amount!;
        else
          daysAmount[daysAmount.length - 1] += -invocies[i].amount!;
      }
    }
    for (int i = 0; i < daysAmount.length; i++) {
        if(maxValue != null && daysAmount[i] > maxValue){
          daysAmount[i] = maxValue.toDouble();
        }
        if(daysAmount[i] > 0)
          data.add(FlSpot(i.toDouble(), daysAmount[i]));
    }
      
    return data;
 }

 Future<List<FlSpot>> getCreditData({required DateTime initialMonth, required DateTime finalMonth, double? maxValue}) async {
    List<String> dates = [];
    List<int> monthsIndex = [];
      for (int i = initialMonth.month; i <= finalMonth.month; i++) {
        int yearIncrementer = initialMonth.month + (i - initialMonth.month) > 12 ? 1 : 0;
        dates.add("%/${i.toString()}/${initialMonth.year + yearIncrementer}");
        monthsIndex.add(i);
      }
      
    List<FlSpot> data = [];
    List<double> daysAmount = List<double>.filled(90, 0.0);
    for (String date in dates) {
      Searchlike searchLike = Searchlike({
        "date": date});
      List<InvoiceDTO> invocies = (await _invoiceService!.ListAllSearch(searchlike: searchLike, search: Search({"type": "credit"})))["invoices"];
    
      
      for (int i = 0; i < invocies.length; i++) {
        int day = int.tryParse(invocies[i].date!.split("/")[0]) ?? 0;
        int month = int.tryParse(invocies[i].date!.split("/")[1]) ?? 0;

        int dayInScale = day + (monthsIndex.indexOf(month) * 30);
        if(dayInScale < daysAmount.length)
          daysAmount[dayInScale] += invocies[i].amount!;
        else{
          daysAmount[daysAmount.length - 1] += invocies[i].amount!;
          }
      }
    }
    for (int i = 0; i < daysAmount.length; i++) {
        if(maxValue != null && daysAmount[i] > maxValue){
          daysAmount[i] = maxValue.toDouble();
        }
        if(daysAmount[i] > 0)
          data.add(FlSpot(i.toDouble(), daysAmount[i]));
      }
    

    return data;
 }
}