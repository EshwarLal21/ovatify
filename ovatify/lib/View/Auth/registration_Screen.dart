import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Helper/appColor.dart';
import '../../Helper/image_Class.dart';
import '../../View/Auth/login_Screen.dart';
import '../../View/Auth/opt_Screen.dart';
import '../../data/apiConstants.dart';
import '../../data/apiHelper.dart';
import '../../widget/btn_custumize.dart';
import '../../widget/iconbtn_custusmize.dart';
import '../../widget/input_field.dart';
import '../../widget/snackbar.dart';
import '../../widget/text.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void registerUser() async {
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (phone.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await ApiService.post(
        ApiConstants.register,
        body: {
          "phone_no": phone,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('✅ Register success: $responseData');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Registration successful')),
        );

        Get.to(() => OptScreen(email: email));
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomLabelText(
                    text: 'Welcome',
                    color: AppColors.magenta,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomLabelText(
                    text: 'Sign up to get started',
                    color: AppColors.white,

                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                CustomFormTextField(
                  error: "Phone No",
                  textStyle: TextStyle(color: Colors.white), // 👈 this line here

                  labelColor: AppColors.white,
                  cursorcolor: AppColors.white,
                  label: "Phone No",
                  icon: Icons.phone,

                  controller: phoneController,
                  keyboardType: TextInputType.phone,

                ),
                SizedBox(height: 3.h),
                CustomFormTextField(
                  textStyle: TextStyle(color: Colors.white), // 👈 this line here

                  error: "Email",
                  labelColor: AppColors.white,
                  cursorcolor: AppColors.white,
                  label: "Email",
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  isEmail: true,
                ),
                SizedBox(height: 1.5.h),
                CustomFormTextField(
                  textStyle: TextStyle(color: Colors.white), // 👈 this line here

                  error: "Password",
                  label: "Password",
                  labelColor: AppColors.white,
                  cursorcolor: AppColors.white,
                  icon: Icons.lock,
                  controller: passwordController,
                  isPassword: true,
                  maxLength: 16,
                  showPasswordStrength: false,
                ),
                SizedBox(height: 1.5.h),
                CustomFormTextField(
                  textStyle: TextStyle(color: Colors.white), // 👈 this line here

                  error: "Confirm Password",
                  label: "Confirm Password",
                  labelColor: AppColors.white,
                  cursorcolor: AppColors.white,
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  isPassword: true,
                  maxLength: 16,
                  showPasswordStrength: false,
                ),
                SizedBox(height: 1.5.h),
                CustomButton(
                  title: 'Sign up',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (passwordController.text.length >= 8) {
                        registerUser();
                      } else {
                        showCustomSnackbar(
                          title: "Error",
                          message: "Your password length should be at least 8",
                          backgroundColor: Colors.red,
                          icon: Icons.error,
                        );
                      }
                    }
                  },
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  borderColor: Colors.blue,
                  borderRadius: 8.0,
                  height: 50.0,
                  width: double.infinity,
                ),
                SizedBox(height: 2.5.h),
                Row(
                  children: <Widget>[
                    Expanded(child: Divider(color: Colors.grey[400])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'OR',
                        style: textTheme.bodySmall?.copyWith(color: AppColors.white),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[400])),
                  ],
                ),
                SizedBox(height: 2.5.h),
                CustomIconButton(
                  title: 'Sign in with Google',
                  onPressed: () {},
                  assetPath: AppImages.google,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  textColor: Colors.white,
                  borderColor: Colors.grey.withOpacity(0.1),
                  borderRadius: 25.0,
                  height: 50.0,
                  width: double.infinity,
                ),
                SizedBox(height: 1.5.h),
                CustomIconButton(
                  title: 'Sign up with Facebook',
                  onPressed: () {},
                  assetPath: AppImages.facebook,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  textColor: Colors.white,
                  borderColor: Colors.grey.withOpacity(0.1),
                  borderRadius: 25.0,
                  height: 50.0,
                  width: double.infinity,
                  iconPosition: IconPosition.left,
                ),
                SizedBox(height: 2.5.h),
                TextButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
