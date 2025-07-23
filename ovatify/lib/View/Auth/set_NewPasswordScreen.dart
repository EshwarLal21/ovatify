import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovatify/Helper/image_Class.dart';
import 'package:ovatify/View/Auth/login_Screen.dart';
import 'package:ovatify/View/Auth/opt_Screen.dart';
import 'package:ovatify/View/home_DetailScreen.dart';
import 'package:ovatify/View/home_Screen.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/appColor.dart';
import '../../widget/alertbox.dart';
import '../../widget/btn_custumize.dart';
import '../../widget/input_field.dart';
import '../../widget/text.dart';
import 'package:http/http.dart' as http;

class SetNewpasswordscreen extends StatefulWidget {
  @override
  _SetNewpasswordscreenState createState() => _SetNewpasswordscreenState();
}

class _SetNewpasswordscreenState extends State<SetNewpasswordscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  bool isRemember = false;
  bool isLoading = false;


  Future<void> resetPassword(String password, String confirmPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('${ApiConstants.baseUrl}/reset/password');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      "password": password,
      "password_confirmation": confirmPassword,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Password reset success: ${data["message"]}');
      } else {
        print('❌ Failed: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('❗ Exception during password reset: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomLabelText(
                  text: 'Create new password',
                  color: AppColors.magenta,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Image.asset(AppImages.cnp),
              SizedBox(height: 3.h),

              Align(
                alignment: Alignment.centerLeft,
                child: CustomLabelText(
                  text: 'Create Your New Password',
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 5.h),
              CustomFormTextField(
                error: "Password",
                label: "Enter your Password",
                labelColor: AppColors.white,
                cursorcolor: AppColors.white,
                icon: Icons.lock,
                controller: passwordController,
                isPassword: true,
                maxLength: 16,
                showPasswordStrength: false,
              ),


              SizedBox(height: 2.h),
              Row(
                children: [
                  Checkbox(
                    value: isRemember,
                    onChanged: (value) {
                      setState(() {
                        isRemember = value!;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRemember = !isRemember;
                      });
                    },
                    child: CustomLabelText(
                       text: 'Remember me',
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),


              const Spacer(),
              CustomButton(
                title: 'Reset',
                onPressed: (){
                  resetPassword(passwordController.text, passwordController.text);
                  Get.to(LoginScreen());
  },
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                borderColor: Colors.blue,
                borderRadius: 8.0,
                height: 50.0,
                width: double.infinity,
              ),
              SizedBox(height: 2.5.h),
              CustomButton(
                title: 'Back',
                onPressed: () {
                  Get.back();
                },
                backgroundColor: Colors.grey.withOpacity(0.1),
                textColor: Colors.white,
                borderColor: Colors.white,
                borderRadius: 8.0,
                height: 50.0,
                borderwidth: 1,
                width: double.infinity,
              ),
              SizedBox(height: 2.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
