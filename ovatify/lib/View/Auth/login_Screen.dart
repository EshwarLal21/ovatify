
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ovatify/View/Auth/forget_Screen.dart';
import 'package:ovatify/View/Auth/registration_Screen.dart';
import 'package:ovatify/View/Auth/set_NewPasswordScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../widget/btn_custumize.dart';
import '../../../widget/iconbtn_custusmize.dart';
import '../../../widget/input_field.dart';
import '../../../widget/snackbar.dart';
import '../../Helper/appColor.dart';
import '../../Helper/image_Class.dart';
import '../../data/apiConstants.dart';
import '../../data/apiHelper.dart';
import '../../data/google_auth_service.dart';
import '../../widget/text.dart';
import '../home_Screen.dart';
import '../main_Screen.dart';
import 'opt_Screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Email/Password Login
  void loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    try {
      final response = await ApiService.post(
        ApiConstants.login,
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('✅ Login Success: $responseData');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Login successful')),
        );

        if (responseData['message'].toLowerCase().contains('verification')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OptScreen(email: email),
            ),
          );
        }

      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['message'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      print('❌ Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  // Google Sign-In Method
  Future<void> signInWithGoogle() async {
    try {
      // This forces showing the account selection dialog by disconnecting the last session
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('Google Sign-In cancelled');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('✅ Google Sign-In successful: ${user.email}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed in as ${user.displayName}')),
        );
        Get.offAll(() => MainScreen());
      }
    } catch (e) {
      print('❌ Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                    text: 'Welcome',
                    color: AppColors.magenta,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  )
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomLabelText(
                    text: 'Login to get started',
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  )
              ),
              SizedBox(height: 3.h),
              CustomFormTextField(
                error: "Email",
                labelColor: AppColors.white,
                cursorcolor: AppColors.white,
                label: "Email",
                textStyle: TextStyle(color: Colors.white),
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
              SizedBox(height: 1.5.h),
              CustomFormTextField(
                error: "Password",
                label: "Password",
                textStyle: TextStyle(color: Colors.white),
                labelColor: AppColors.white,
                cursorcolor: AppColors.white,
                icon: Icons.lock,
                controller: passwordController,
                isPassword: true,
                maxLength: 16,
                showPasswordStrength: false,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetScreen()));
                  },
                  child: Text('Forgot Password?', style: textTheme.bodySmall?.copyWith(color: AppColors.primary)),
                ),
              ),
              SizedBox(height: 1.5.h),
              CustomButton(
                title: 'Login',
                onPressed: () async {
                  loginUser();
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
                    child: Text('OR', style: textTheme.bodySmall?.copyWith(color: AppColors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.grey[400])),
                ],
              ),
              SizedBox(height: 2.5.h),
              CustomIconButton(
                title: 'Sign in with Google',
                onPressed: () async {
                  await signInWithGoogle();
                },
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
                onPressed: () async {
                  Get.to(() => MainScreen());
                },
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
                  Get.to(() => RegistrationScreen());
                },
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: 'Don’t have an account? '),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
