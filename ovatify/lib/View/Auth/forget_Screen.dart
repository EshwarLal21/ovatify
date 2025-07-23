import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovatify/Helper/image_Class.dart';
import 'package:ovatify/View/Auth/opt_Screen.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart'as http;
import '../../Helper/appColor.dart';
import '../../widget/btn_custumize.dart';
import '../../widget/input_field.dart';
import '../../widget/snackbar.dart';
import '../../widget/text.dart';
import 'forget_OtpScreen.dart';


class ForgetScreen extends StatefulWidget {

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _otpControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
        ),
      ),
    );
  }

  void _submitOtp() {
    final otp = _otpControllers.map((e) => e.text).join();
    if (otp.length == 4) {
      print('Entered OTP: $otp');
    } else {
      showCustomSnackbar(
        title: "Error",
        message: "Please enter all 4 digits",
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  Future<void> forgetPassword(String email) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/forget/password');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      "email": email,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Forgot password request sent: ${data["message"]}');
      } else {
        print('❌ Failed: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('❗ Exception during forgot password: $e');
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
                  text: 'Forgot Password',
                  color: AppColors.magenta,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomLabelText(
                  text: 'Select which contact details should we use to reset your password',
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 5.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.email,
                      height: 15.h,
                      width: 30.w,
                    ),
                    SizedBox(width: 12),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabelText(
                           text: 'via SMS:',
                          color: AppColors.primary,
                          textAlign: TextAlign.start,
                        ),
                        CustomLabelText(
                           text: '+1 111 ******99',
                          color: AppColors.white,
                          textAlign: TextAlign.start,
                        ),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 3.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), // semi-transparent background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.phonemsg,
                      height: 15.h,
                      width: 30.w,
                    ),
                    SizedBox(width: 12),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabelText(
                          text: 'via Email:',
                          color: AppColors.primary,
                          textAlign: TextAlign.start,
                        ),
                        CustomLabelText(
                          text: '**ley@yourdomain.com',
                          color: AppColors.white,
                          textAlign: TextAlign.start,
                        ),

                      ],
                    )                  ],
                ),
              ),
              SizedBox(height: 3.h),
              CustomFormTextField(
                error: "Email",
                labelColor: AppColors.white,
                cursorcolor: AppColors.white,
                label: "Email",
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),

              const Spacer(),
              CustomButton(
                title: 'Continue',
                onPressed: (){
                  if(emailController.text.isNotEmpty){
                    forgetPassword(emailController.text).then((value){
                      Get.to(() => ForgetOtpscreen(email: emailController.text,));
                    });
                  }else{
                    Get.snackbar('Empty Field', 'Enter Email to continue');
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
