import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:saving_tools/Services/GoalService.dart';
import 'package:saving_tools/pages/Invoices/AddInvoice/FormParts/DatePicker.dart';
import 'package:saving_tools/pages/goals/GoalList.dart';



class AddGoal extends StatefulWidget {
  GlobalKey<GoalsListState>? listKey;
  AddGoal({Key? key, required GlobalKey<GoalsListState>?  listKey}) : super(key: key){
    this.listKey = listKey;
  }

  @override
  _AddGoalState createState() => _AddGoalState(listKey: listKey!);
}

class _AddGoalState extends State<AddGoal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<GoalsListState>? _goalList;
  _AddGoalState({required GlobalKey<GoalsListState> listKey}) : _goalList = listKey;

  TextEditingController calendarTextContent = TextEditingController();
  TextEditingController descriptionTextContent = TextEditingController();
  TextEditingController amountTextContent = TextEditingController();
  TextEditingController percentDestribution = TextEditingController(text:"100");
  bool isVisible = true;
  int rank = 1;
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
              children: [
                  Container(
                  color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_score,
                          color: const Color.fromARGB(255, 9, 102, 45),
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Text(
                          "Add Goal",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible ? Icons.arrow_drop_down : Icons.arrow_drop_up,)
                        )
                        ],
                      ),
                    ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(top:15,left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Description of the goal:",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17,
                          )
                        )
                      )
                    ],
                  )
                )
                ),
                Visibility(
                  visible: isVisible,
                  child:
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left:20, right:20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: descriptionTextContent,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),

                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(      
                              borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),   
                              ),  
                              focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),
                                  ),
                            
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          )
                        )
                      ],
                    )
                  )
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top:30,left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Expeted date of completion:",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17,
                          )
                        )
                      )
                    ],
                  )
                )
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top:15,left:20, right:20),
                  child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: calendarTextContent,
                            validator: calendarValidator,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(      
                                borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),   
                                ),  
                                focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),
                                    ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          // color: Colors.white,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: DatePicker(
                            onDateSelected: (date) {
                              setState(() {
                                calendarTextContent.text = "${date.day}/${date.month}/${date.year}";
                              });
                            },
                          ),
                        ))
                  ],
                  )
                  )
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top:30,left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          "Amount needed to reach the goal:",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17,
                          )
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Rank",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17
                          )
                        ))
                    ],
                  )
                  )
                ),
                Visibility(
                  visible: isVisible,
                  child:
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: amountTextContent,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            
                            enabledBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),   
                            ),  
                            focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),
                                ),
                          
                          ),
                          validator: amountValidator,
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                              "€",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 102, 45),
                                fontSize: 20,
                              )
                            ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: FutureBuilder<List<int>>(
                            future: GetRanksAvailable(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButton<int>(
                                  value: snapshot.data![0],
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  elevation: 16,
                                  
                                  style:
                                      TextStyle(
                                        color: const Color.fromARGB(255, 9, 102, 45),
                                        fontSize: 20,
                                        
                                        ),
                                  underline: Container(
                                    height: 2,
                                    color:  Color.fromARGB(255, 9, 102, 45),
                                  ),
                                  onChanged: (int? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      rank = value!;
                                      
                                    });
                                  },
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<int>>((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString(),
                                        textAlign: TextAlign.center, style: TextStyle(
                                        color: const Color.fromARGB(255, 9, 102, 45),
                                        fontSize: 20,
                                      )
                                      )
                                    );
                                  }).toList(),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        ),
                      )
                    ],
                  )
                )
                ),
                Visibility(
                  visible: isVisible,
                  child:
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top:30,left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Percentage of your earned will be dedicated to this goal:",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 9, 102, 45),
                            fontSize: 17,
                          )
                        )
                      )
                    ],
                  )
                )
                ),
                Visibility(
                  visible: isVisible,
                  child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left:20, right:20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: LinearPercentIndicator(
                                    // width: MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 1000,
                                    percent: (double.tryParse(percentDestribution.text) ?? 1) / 100,
                                    center: Text(
                                      percentDestribution.text + "%",
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    )
                                    ),
                                    barRadius: Radius.circular(30),
                                    progressColor: Colors.green,
                                  )
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          validator: (value) {
                              if(double.tryParse(value!) == null){
                                return 'Please enter a number';
                              }
                              else if(double.parse(value) > 100){
                                return 'Please enter a number between 0 and 100';
                              }
                              else if (double.parse(value) < 0){
                                return 'Please enter a number between 0 and 100';
                              }
                              return null;
                          },
                          onChanged: (value) => setState(() {
                            if (value.isEmpty) {
                              percentDestribution.text = "0";
                            } 
                            else if (double.tryParse(value) != null) {
                              if (double.parse(value) > 100) {
                                percentDestribution.text = "100";
                              }
                              else if(double.parse(value) < 0){
                                percentDestribution.text = "0";
                              }
                              else {
                                percentDestribution.text = value;
                              }
                            }
                          
                          }),
                          controller: percentDestribution,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),   
                            ),  
                            focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: const Color.fromARGB(255, 9, 102, 45)),
                                ),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                              "%",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 102, 45),
                                fontSize: 20,
                              )
                            ),
                        ),
                      )
                    ],
                  )
                )
                ),
                Visibility(
                  visible: isVisible,
                  child:
                Container(
                  padding: EdgeInsets.only(top: 30),
                  color: Colors.white,
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        ElevatedButton(
                        style: ButtonStyle(
                          
                          backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 0, 193, 74)),
                        ),
                        onPressed: () {
                          SubmitGoal();
                        },
                        child: Text(
                              'Submit',
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                      ),
                      ])
                )
                )

              ],
          )
        ),
      ),
    );
  }

  Future<List<int>> GetRanksAvailable() async{
    return await GoalService().getRanksAvailable(); 
  }
  String? amountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    if(double.tryParse(value) == null){
      return 'Please enter a number';
    }
    return null;
  }


   String? calendarValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invalid date';
    }
    List<String> dateParts = value.split("/");
    if (dateParts.length != 3) {
      return 'Invalid date';
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    if (day < 1 || day > 31) {
      return 'Invalid date';
    } else if (day < 10) {
      dateParts[0] = "0$day";
    }
    if (month < 1 || month > 12) {
      return 'Invalid date';
    } else if (month < 10) {
      dateParts[1] = "0$month";
    }
    if (year < 2000 || year > 2100) {
      return 'Invalid date';
    }
    if(DateTime.utc(year, month, day).isBefore(DateTime.now())){
      return 'Date should be in the future';
    }
    setState(() {
      date = DateTime.utc(year, month, day);
    });
    return null;
  }

  void SubmitGoal() async {
    if (_formKey.currentState!.validate()) {
      await GoalService().addGoal(
        description: descriptionTextContent.text,
        date: date,
        amount: double.parse(amountTextContent.text),
        distributionPercentage: double.parse(percentDestribution.text),
        rank: rank
        );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added goal successfully!')));
    _goalList!.currentState!.setState(() {
      
    });
    setState(() {
      descriptionTextContent.text = "";
      calendarTextContent.text = "";
      amountTextContent.text = "";
      percentDestribution.text = "100";
      rank = 1;
    });
    }
  }
}