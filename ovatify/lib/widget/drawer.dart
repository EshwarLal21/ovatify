// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
//
//
// class SideMenu extends StatefulWidget {
//   @override
//   _SideMenuState createState() => _SideMenuState();
// }
//
// class _SideMenuState extends State<SideMenu> {
//   String selectedMenu = "";
//   bool email = false;
//   bool task = false;
//   bool meeting = false;
//   bool aichat = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         color: Colors.white,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             SizedBox(
//               height: 10.h,
//               child: DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.white),
//                 margin: EdgeInsets.zero,
//                 padding: EdgeInsets.zero,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/Rectangle.png', height: 40),
//                     SizedBox(width: 10),
//                     Text(
//                       "AI Assistant",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             menuItem(
//               title: "Dashboard",
//               icon: Icons.dashboard,
//               isSelected: selectedMenu == "Dashboard",
//               onTap: () {
//                 setState(() {
//                   selectedMenu = "Dashboard";
//                   email = false;
//                   meeting = false;
//                 });
//                 Navigator.of(context).pop();
//
//               },
//             ),
//             menuItem(
//               title: "Emails",
//               icon: Icons.email,
//               iconf: email ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//               isSelected: selectedMenu == "Emails",
//               onTap: () {
//                 setState(() {
//                   selectedMenu = "Emails";
//                   email = !email;
//                 });
//               },
//             ),
//             if (email == true) ...[
//               menuItem(
//                 title: "Urgent",
//                 icon: Icons.email,
//                 isSelected: selectedMenu == "Urgent",
//                 onTap: () {
//                   setState(() => selectedMenu = "Urgent");
//                   Navigator.of(context).pop();
//                   // Get.to(() => UrgentmailsScreen());
//                 },
//               ),
//               menuItem(
//                 title: "Normal",
//                 icon: Icons.email,
//                 isSelected: selectedMenu == "Normal",
//                 onTap: () {
//                   setState(() => selectedMenu = "Normal");
//                   Navigator.of(context).pop();
//                   // Get.to(() => NormalemailScreen());
//                 },
//               ),
//               menuItem(
//                 title: "Informational",
//                 icon: Icons.email,
//                 isSelected: selectedMenu == "Informational",
//                 onTap: () {
//                   setState(() => selectedMenu = "Informational");
//                   Navigator.of(context).pop();
//                   // Get.to(() => InformationalemailScreen());
//                 },
//               ),
//             ],
//
//             menuItem(
//               title: "Tasks",
//               icon: Icons.task,
//               iconf: task ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//
//               isSelected: selectedMenu == "Tasks",
//               onTap: () {
//                 setState(() => selectedMenu = "Tasks");
//                 Navigator.of(context).pop();
//
//                 // Get.to(() => TasklistScreen());
//               },
//             ),
//
//             menuItem(
//               title: "Meetings",
//               icon: Icons.video_camera_front_outlined,
//               iconf: meeting ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//
//               isSelected: selectedMenu == "Meetings",
//               onTap: () {
//                 setState(() {
//                   selectedMenu = "Meetings";
//                   meeting = !meeting;
//                 });
//               },
//             ),
//             if (meeting) ...[
//               menuItem(
//                 title: "Voice To Text",
//                 icon: Icons.record_voice_over_outlined,
//                 isSelected: selectedMenu == "Voice To Text",
//
//                 onTap: () {
//                   setState(() {
//                     selectedMenu = "Voice To Text";
//                     meeting = !meeting;
//                     Navigator.of(context).pop();
//
//                     Get.to(() => VoiceToTextScreen());
//                   });
//                 },
//               ),
//               menuItem(
//                 title: "Participants",
//                 icon: Icons.person_outline_outlined,
//
//                 isSelected: selectedMenu == "Participants",
//                 onTap: () {
//                   setState(() {
//                     selectedMenu = "Participants";
//                     meeting = !meeting;
//                     Get.to(() => ParticipantsScreen());
//                   });
//                 },
//               ),
//             ],
//
//             menuItem(
//               title: "AI Chat",
//               icon: Icons.chat,
//               iconf: aichat ? Icons.arrow_drop_up : Icons.arrow_drop_down,
//               isSelected: selectedMenu == "AI Chat",
//               onTap: () {
//                 setState(() {
//                   selectedMenu = "AI Chat";
//                   aichat = !aichat;
//                 });
//               },
//             ),
//
//             if (aichat) ...[
//               menuItem(
//                 title: "New Chat",
//                 icon: Icons.chat,
//
//                 isSelected: selectedMenu == "New Chat",
//                 onTap: () {
//                   setState(() {
//                     selectedMenu = "New Chat";
//                     aichat = !aichat;
//                     Get.to(() => ChatScreen());
//                   });
//                 },
//               ),
//               //   menuItem(
//               //   title: "Last conversation",
//               //   icon: Icons.chat,
//               //
//               //   isSelected: selectedMenu == "Last conversation",
//               //
//               //   onTap: () => setState(() => selectedMenu = "Last conversation"),
//               // ),
//               menuItem(
//                 title: "Previous conversation",
//                 icon: Icons.chat,
//
//                 isSelected: selectedMenu == "Previous conversation",
//
//                 onTap:
//                     () =>
//                         setState(() => selectedMenu = "Previous conversation"),
//               ),
//
//               //   menuItem(
//               //   title: "Older conversation",
//               //   icon: Icons.chat,
//               //
//               //   isSelected: selectedMenu == "Older conversation",
//               //
//               //   onTap: () => setState(() => selectedMenu = "Older conversation"),
//               // ),
//             ],
//
//             menuItem(
//               title: "Logout",
//               icon: Icons.logout,
//               isSelected: false,
//               logout: true,
//               textColor: Colors.red,
//               iconColor: Colors.red,
//               onTap: () async {
//                 await SecureStorage.deleteToken();
//                 Get.offAll(() => LoginScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget menuItem({
//     required String title,
//     required IconData icon,
//     IconData? iconf,
//     required bool isSelected,
//     bool logout = false,
//     Color textColor = Colors.black,
//     Color iconColor = Colors.blue,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         color:
//             logout
//                 ? Colors.red.shade50
//                 : isSelected
//                 ? Colors.blue
//                 : Colors.blueGrey.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isSelected ? Colors.white : textColor,
//               ),
//             ),
//             Icon(iconf, color: isSelected ? Colors.white : iconColor),
//           ],
//         ),
//         leading: Icon(icon, color: isSelected ? Colors.white : iconColor),
//         onTap: onTap,
//       ),
//     );
//   }
//
//   Widget expansionMenu({
//     required String title,
//     required IconData icon,
//     required bool isSelected,
//     required List<String> children,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.grey.shade200,
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           title: Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               color: isSelected ? Colors.blue : Colors.black,
//             ),
//           ),
//           leading: Icon(icon, color: isSelected ? Colors.blue : Colors.blue),
//           children:
//               children.map((child) {
//                 return ListTile(
//                   title: Text(
//                     child,
//                     style: TextStyle(fontSize: 14, color: Colors.black),
//                   ),
//                   onTap: () => setState(() => selectedMenu = title),
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }
