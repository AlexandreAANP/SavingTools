import 'package:flutter/material.dart';
import 'package:saving_tools/pages/Invoices/ListInvoices/ListInvoiceParts/InvoiceListTable.dart';

class ListInvoicePagintation extends StatefulWidget {
  final GlobalKey<InvoiceListTableState> listTableState;
  ListInvoicePagintation(this.listTableState,{Key? key}) : super(key: key);

  @override
  _ListInvoicePagintationState createState() => _ListInvoicePagintationState(this.listTableState);
}

class _ListInvoicePagintationState extends State<ListInvoicePagintation> {
  final GlobalKey<InvoiceListTableState> ListTableState;
  _ListInvoicePagintationState(this.ListTableState);

  int maxPages = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => previousPage(),
          ),
          ..._buildPagination(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => nextPage(),
          ),
        ],
      ),
    );
  }

  void nextPage(){
    if(this.ListTableState.currentState!.pageIndex < getNumberOfGetPages()){
      this.ListTableState.currentState!.setState(() {
        this.ListTableState.currentState!.pageIndex++;
      });

    }
  }

  void previousPage(){
    if(this.ListTableState.currentState!.pageIndex > 1){
      this.ListTableState.currentState!.setState(() {
        this.ListTableState.currentState!.pageIndex--;
      });
    }
  }
  void toPage(int pageNumber){
    if(pageNumber > 0 && pageNumber <= getNumberOfGetPages()){
      this.ListTableState.currentState!.setState(() {
        this.ListTableState.currentState!.pageIndex = pageNumber;
      });
    }
  }

  int getNumberOfGetPages(){
    double numberpages = this.ListTableState.currentState!.numberOfInvoices / this.ListTableState.currentState!.limit;
    return numberpages.ceil();
  }

  List<Widget> _buildPagination() {
    List<Widget> pagination = [];
    int pages = getNumberOfGetPages();
    int pageBeginer = this.ListTableState.currentState!.pageIndex - maxPages;
    if (pageBeginer < 0) {
      pageBeginer = 0;
    }else if(pageBeginer == 0){
      pageBeginer = 1;
    }
    int pagesCreated = 0;
    for (int i = 1 + pageBeginer; i <= pages; i++) {
      pagesCreated++;
      if (i == this.ListTableState.currentState!.pageIndex) {
        pagination.add(pageNumber(i,isMainPage: true));
        
      }else{
        pagination.add(pageNumber(i));
      }
      if (pagesCreated >= maxPages) {
        pagination.add(Text("..."));
        break;
      }
    }
    return pagination;
  }



  Widget pageNumber(int pageNumber,{bool isMainPage = false}){
    return GestureDetector(
      onTap: () => toPage(pageNumber),
      child:Container(
        padding: EdgeInsets.all(5),
        child:Text(
            pageNumber.toString()+ "  ",
            style: TextStyle(
              fontWeight: isMainPage ? FontWeight.bold : null,
              fontSize: isMainPage ? 20 : 18,
              )
            )
        )
      );
    
  }
}