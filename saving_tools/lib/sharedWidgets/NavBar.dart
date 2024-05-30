import 'package:flutter/material.dart';
import 'package:saving_tools/sharedWidgets/ToolBarMessages.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        if (ModalRoute.of(context)!.settings.name == '/profile') {
          return;
        }
        Navigator.popAndPushNamed(context, '/profile');
        break;
      case 1:
        if (ModalRoute.of(context)!.settings.name == '/main') {
          return;
        }
        Navigator.popAndPushNamed(context, '/main');
        break;
      case 2:
        if (ModalRoute.of(context)!.settings.name == '/addInvoice') {
          return;
        }
        Navigator.popAndPushNamed(context, '/addInvoice');
        break;
      
    }
    

    
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Expense',
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: const Color.fromARGB(255, 17, 155, 70),
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: Color.fromARGB(255, 192, 241, 208),
      selectedFontSize: 15,
      onTap: _onItemTapped,
    );
  }
}


// class NavBar extends BottomNavigationBar {
//   NavBar({Key? key})
//       : super(
//             onTap: changePage,
//             backgroundColor: const Color.fromARGB(255, 17, 155, 70),
//             selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
//             unselectedItemColor: Color.fromARGB(255, 192, 241, 208),
//             selectedFontSize: 15,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.search,
//                 ),
//                 label: 'Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.search,
//                 ),
//                 label: 'Favorites',
//               ),
//             ]);


//     void changePage(int index) {
//       switch (index) {
//         case 0:

//     }
// }
