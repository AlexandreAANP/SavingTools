import 'package:flutter/material.dart';


class ToolBarMessages extends StatefulWidget {
  const ToolBarMessages({Key? key}) : super(key: key);


  //_ToolBarMessagesState e = _ToolBarMessagesState();

  @override
  State<ToolBarMessages> createState() => _ToolBarMessagesState();
}

class _ToolBarMessagesState extends State<ToolBarMessages>{
  
  List<String> Messages = [];
  double index = 0;
  int timesSlide = 0;
  ScrollController _scrollController = ScrollController();
  _ToolBarMessagesState({List<String>? Messages = null}){
    if(Messages != null && Messages.isNotEmpty){
      this.Messages = Messages;
    }
    else{
      this.Messages = [
        "Hello, World!",
        "Welcome to Saving Tools!",
        "This is a simple app to help you save money.",
        "This is a simple app to help you save money.This is a simple app to help you save money."
      ];
    }
    loopSlideToolBar();
  }

  void AddMessage(String NewMessage) {
    setState(() {
      Messages.add(NewMessage);
    });
  }
  void RemoveMessage(String DeleteMessage){
    setState(() {
      Messages.remove(DeleteMessage);
    });
  }
  
  void loopSlideToolBar() async {
    while(true){
      await Future.delayed(Duration(seconds: 5));
      SlideToolBar();
    }
  }


  void SlideToolBar(){

    this.index += MediaQuery.of(context).size.width + 20; // the 20 it's the margin width added to the container
    SlideToBar(offset: this.index, time: Duration(seconds: 2));
    
    if(this.timesSlide == Messages.length-1){
      this.index = 0;
      this.timesSlide = 0;
      //Slide to beginning
      SlideToBar(offset: 0, time: Duration(milliseconds: 1));

    }
    else{
      this.timesSlide++;
    }
  }

  void SlideToBar({required double offset, required Duration time}){

    _scrollController.animateTo(
      offset,
      duration: time,
      curve: Curves.easeInOut
      );
  }

  _RedirectToMessagePage(String Message){
    //Redirect to message page
    print("TODO: Should redirect to message page. Message: \"$Message\"");
  }

  @override
  Widget build(BuildContext context) {
    ListView MessageList = ListView.builder(
      controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Messages.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width, //get full width
            child: GestureDetector(
              onDoubleTap: () => _RedirectToMessagePage(Messages[index]), //Redirect to message page
              child: Text(
                Messages[index],
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 9, 102, 45),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                selectionColor: const Color.fromARGB(255, 0, 170, 65),
              )
            ),
          ); 
    
      },
    );

    return Container(
          color: const Color.fromARGB(255, 192, 241, 208),
          height: 30,
          child: MessageList,
        );

  }
}