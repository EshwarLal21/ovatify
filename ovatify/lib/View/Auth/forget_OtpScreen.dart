import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovatify/View/Auth/set_NewPasswordScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../widget/btn_custumize.dart';
import '../../../widget/snackbar.dart';
import '../../Helper/appColor.dart';
import '../../data/apiConstants.dart';
import '../../widget/text.dart';

class ForgetOtpscreen extends StatefulWidget {
  final String email;

  const ForgetOtpscreen({super.key, required this.email});
  @override
  _ForgetOtpscreenState createState() => _ForgetOtpscreenState();
}

class _ForgetOtpscreenState extends State<ForgetOtpscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers =
  List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
bool isLoading = false;
  @override
  void dispose() {
    for (final c in _otpControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }
  Future<void> verifyOtp() async {
    String otpCode = _otpControllers.map((controller) => controller.text).join();


    if (otpCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter OTP code")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.verify}'), // Replace with actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "code": int.parse(otpCode),
          "email": widget.email,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Verification successful')),
        );
        print(response.statusCode);
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SetNewpasswordscreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Verification failed')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 10.w,
      height: 5.h,
      margin:  EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.9)),
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
            if (value.isNotEmpty && index < 4) {
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
      Get.to(() => SetNewpasswordscreen());

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
                  text: 'Code has been sent to \n${widget.email}',
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildOtpBox(index)),
              ),

              SizedBox(height: 5.h),

              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Resend code in ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextSpan(
                        text: '55',
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' s',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),
              CustomButton(
                title: 'Verify',
                onPressed: verifyOtp,
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
