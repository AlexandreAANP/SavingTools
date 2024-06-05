import 'package:flutter/material.dart';

class MainDrawer extends Drawer{

  MainDrawer({Key? key, required BuildContext context}) : super(
                                key: key,
                                backgroundColor: const Color.fromARGB(255, 0, 170, 65),
                                child: ListView(
                                  children: [
                                    DrawerHeader(
                                      decoration: BoxDecoration(
                                        
                                      ),
                                      child: Text(
                                        'Menu',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold
                                        ),
                                    )
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.home, color: Colors.white),
                                      title: Text(
                                        'Home',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        )
                                        ),
                                      onTap: () {
                                        if (ModalRoute.of(context)!.settings.name == '/main') {
                                            return;
                                          }
                                          Navigator.popAndPushNamed(context, '/main');
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.add, color: Colors.white),
                                        title: Text(
                                        'Add Invoice',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          
                                        ),
                                        ),
                                      onTap: () {
                                        if (ModalRoute.of(context)!.settings.name == '/addInvoice') {
                                            return;
                                          }
                                          Navigator.popAndPushNamed(context, '/addInvoice');
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.list, color: Colors.white),
                                        title: Text(
                                        'List Invoice',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          
                                        ),
                                        ),
                                      onTap: () {
                                        if (ModalRoute.of(context)!.settings.name == '/listInvoice') {
                                            return;
                                          }
                                          Navigator.popAndPushNamed(context, '/listInvoice');
                                      },
                                    ),
                                    
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      leading: Icon(Icons.person, color: Colors.white),
                                        title: Text(
                                        'Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          
                                        ),
                                        ),
                                      onTap: () {
                                         if (ModalRoute.of(context)!.settings.name == '/profile') {
                                            return;
                                          }
                                          Navigator.popAndPushNamed(context, '/profile');
                                      },
                                    ),
                                    
                                  ],
                                ),
  );

}