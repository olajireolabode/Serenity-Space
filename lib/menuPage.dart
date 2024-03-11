// // menu_page.dart
// import 'package:flutter/material.dart';
// import 'homePage.dart';
// import 'userInfoPage.dart'; // Import the UserInfoPage file
//
// class MenuPage extends StatefulWidget {
//   const MenuPage({Key? key}) : super(key: key);
//
//   @override
//   _MenuPageState createState() => _MenuPageState();
// }
//
// class _MenuPageState extends State<MenuPage> {
//   int _selectedIndex = 0;
//
//   // Pages to be displayed in the bottom navigation
//   final List<Widget> _pages = [
//     HomePage(),
//     UserInfoPage(), // Add your UserInfoPage widget here
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'User Info',
//           ),
//         ],
//       ),
//     );
//   }
// }
