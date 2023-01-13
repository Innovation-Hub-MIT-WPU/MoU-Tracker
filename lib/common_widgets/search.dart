// import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/Tabs/mou_deadline_status.dart';
// import 'package:flutter/material.dart';

// import '../classes/mou.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => SearchState();
// }

// int toggle = 0;

// class SearchState extends State<Search> with TickerProviderStateMixin {
//   late AnimationController _con;
//   late TextEditingController textEditingController;
//   @override
//   void initState() {
//     textEditingController = TextEditingController();

//     _con = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 375),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _con.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       padding: EdgeInsets.only(
//         top: screenHeight * 0.015,
//         left: screenHeight * 0.083,
//       ),
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           height: screenHeight * 0.085,
//           width: screenWidth,
//           padding: EdgeInsets.only(
//             top: screenHeight * 0.005,
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(
//                   left: screenHeight * 0.085,
//                   top: screenHeight * 0.007,
//                 ),
//                 child: const Text(
//                   'Approvals',
//                   style: TextStyle(fontSize: 25, color: Colors.white),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 375),
//                 height: 42.0,
//                 width: (toggle == 0) ? 48.0 : 250.0,
//                 curve: Curves.easeOut,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       spreadRadius: -10.0,
//                       blurRadius: 10.0,
//                       offset: Offset(0.0, 10.0),
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     AnimatedPositioned(
//                       duration: const Duration(milliseconds: 375),
//                       left: (toggle == 0) ? 20.0 : 40.0,
//                       curve: Curves.easeOut,
//                       top: 6.0,
//                       child: AnimatedOpacity(
//                         opacity: (toggle == 0) ? 0.0 : 1.0,
//                         duration: const Duration(milliseconds: 200),
//                         child: Container(
//                           height: screenHeight * 0.03,
//                           width: screenWidth * 0.4,
//                           child: TextField(
//                             onChanged: (value) {
//                               setState(() {
//                                 MouStatusTabState().mouList = runFilter(
//                                     textEditingController.text
//                                         .toString()
//                                         .trim());
//                               });
//                             },
//                             style: TextStyle(fontSize: 18),
//                             controller: textEditingController,
//                             cursorRadius: const Radius.circular(10.0),
//                             cursorWidth: 2.0,
//                             cursorColor: Colors.black,
//                             decoration: InputDecoration(
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.never,
//                               labelText: 'Search...',
//                               labelStyle: const TextStyle(
//                                 color: Color(0xff5B5B5B),
//                                 fontSize: 17.0,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               alignLabelWithHint: true,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Material(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30.0),
//                       child: IconButton(
//                         splashRadius: 19.0,
//                         icon: const Icon(Icons.search),
//                         onPressed: () {
//                           setState(
//                             () {
//                               if (toggle == 0) {
//                                 toggle = 1;
//                                 _con.forward();
//                               } else {
//                                 toggle = 0;
//                                 textEditingController.clear();
//                                 _con.reverse();
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<MOU> runFilter(String value) {
//     final search1 = MouStatusTabState().mouList.where((element) {
//       final name = element.docName.toString().toLowerCase();
//       final desc = element.description.toString().toLowerCase();
//       final q = value.toLowerCase();
//       if (name.contains(q)) {
//         return name.contains(q);
//       } else {
//         return desc.contains(q);
//       }
//     }).toList();
//     print(search1);
//     return MouStatusTabState().mouList = search1;
//   }
// }
