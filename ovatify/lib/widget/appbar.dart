import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotificationIcon;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showNotificationIcon = true,
    this.onNotificationPressed,
    this.onProfilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/Rectangle.png', height: 50),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (showNotificationIcon)
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: onNotificationPressed ?? () {},
                ),
              GestureDetector(
                onTap: onProfilePressed,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child:   Image.asset('assets/Ellipse.png', height: 5.h),

                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
