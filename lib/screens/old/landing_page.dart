// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'home_screen.dart';
// import 'loading_screen.dart';
//
// class LandingPage extends StatefulWidget {
//   @override
//   _LandingPageState createState() => _LandingPageState();
// }
//
// class _LandingPageState extends State<LandingPage> {
//   int selectedOptionIndex = 0;
//   List<Widget> bottomNavigationBarOptions = [
//     HomeScreen(),
//     LoadingScreen(),
//     LoadingScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Theme.of(context).accentColor,
//           mini: true,
//           //Floating action button on Scaffold
//           onPressed: () {
//             //code to execute on button press
//           },
//           child: Icon(Icons.shopping_cart), //icon inside button
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         bottomNavigationBar: _buildBottomNavigationBar(),
//         body: IndexedStack(
//           index: selectedOptionIndex,
//           children: bottomNavigationBarOptions,
//         ));
//   }
//
//   Widget _buildBottomNavigationBar() {
//     List<String> bottomNavigationBarText = ['Home', 'Search', 'Profile'];
//
//     List<IconData> bottomNavigationBarIcons = [
//       Icons.home,
//       Icons.search,
//       Icons.person_outline
//     ];
//
//     return BottomAppBar(
//       elevation: 1,
//       color: Theme.of(context).primaryColor,
//       shape: CircularNotchedRectangle(),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(32.0, 16.0, 90, 16.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // decoration: BoxDecoration(color: Color(0xffffffff)),
//           children: List.generate(bottomNavigationBarOptions.length, (index) {
//             if (index == selectedOptionIndex) {
//               return Container(
//                 /////flex: 2,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedOptionIndex = index;
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           bottomNavigationBarIcons[index],
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           bottomNavigationBarText[index],
//                           style: GoogleFonts.ubuntu(
//                               color: Theme.of(context).primaryColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//
//             return Container(
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedOptionIndex = index;
//                   });
//                 },
//                 child: Icon(
//                   bottomNavigationBarIcons[index],
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
