import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;

  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse('https://ovatify.betfastwallet.com/api/user/me'),
        headers: {
          'Content-Type': 'application/json',
          // Add authentication token if required (e.g., from SharedPreferences)
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          profileData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          profileData = {'name': 'Error', 'email': 'Failed to load'};
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        profileData = {'name': 'Error', 'email': 'Network issue'};
      });
    }
  }

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

  void _navigateToEditProfile() {
    // Navigate to edit profile screen (implement separately)
    Navigator.pushNamed(context, '/editProfile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.title, scale: 6),
                      CustomLabelText(
                        text: 'Explore',
                        color: AppColors.magenta,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                      CustomLabelText(
                        text: 'Your Profile',
                        color: AppColors.white,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColors.white),
                    onPressed: _navigateToEditProfile,
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: profileData?['profilePic'] != null
                      ? NetworkImage(profileData!['profilePic'])
                      : AssetImage(AppImages.profile) as ImageProvider,
                  backgroundColor: Colors.grey,
                ),
              ),
              SizedBox(height: 3.h),
              Center(
                child: CustomLabelText(
                  text: profileData?['name'] ?? 'Loading...',
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 4.h),
              CustomLabelText(
                text: 'Profile Details',
                color: AppColors.white,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
              SizedBox(height: 2.h),
              _buildDetailRow('Name', profileData?['name'] ?? 'User 1234'),
              _buildDetailRow('Email', profileData?['email'] ?? 'abc123@gmail.com'),
              _buildDetailRow('Phone No', profileData?['phone'] ?? '+01 000 0000 00'),
              _buildDetailRow('Status', profileData?['status'] ?? 'Creator'),
              _buildDetailRow('Total Amount Invested', profileData?['totalAmountInvested'] ?? '500.00'),
              SizedBox(height: 4.h),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.magenta,
        unselectedItemColor: AppColors.green,
        onTap: _onItemTapped,
        backgroundColor: AppColors.black,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomLabelText(
            text: label,
            color: AppColors.white,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          CustomLabelText(
            text: value,
            color: AppColors.green,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }
}