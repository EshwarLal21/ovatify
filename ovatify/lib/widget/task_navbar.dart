// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../Controller/taskcontroller.dart';
// import '../screen/task/taskScreen.dart';
//
// class TaskNavbar extends StatelessWidget {
//   final TaskController controller;
//
//   TaskNavbar({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedNotchBottomBar(
//       notchBottomBarController: controller.taskNavbarController,
//       kIconSize: 20.0,
//       kBottomRadius: 20.0,
//       showLabel: true,
//       color: Colors.blue,
//       notchColor: Colors.blue,
//       bottomBarItems: [
//         BottomBarItem(
//           inActiveItem: Icon(Icons.today, color: Colors.white),
//           activeItem: Icon(Icons.today, color: Colors.white),
//           itemLabel: "Today",
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(Icons.upcoming, color: Colors.white),
//           activeItem: Icon(Icons.upcoming, color: Colors.white),
//           itemLabel: "Upcoming",
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(Icons.search_rounded, color: Colors.white),
//           activeItem: Icon(Icons.search_rounded, color: Colors.white),
//           itemLabel: "Search",
//         ),
//         BottomBarItem(
//           inActiveItem: Icon(Icons.assignment, color: Colors.white),
//           activeItem: Icon(Icons.assignment, color: Colors.white),
//           itemLabel: "Project",
//         ),
//       ],
//       onTap: (index) {
//         controller.selectedIndex.value = index;
//         controller.taskNavbarController.jumpTo(index);
//       },
//     );
//   }
// }
