import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovatify/View/home_Screen.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/appColor.dart';
import '../../data/auth_service.dart';
import '../../widget/btn_custumize.dart';
import '../../widget/snackbar.dart';
import '../../widget/text.dart';
import 'package:http/http.dart' as http;

import '../main_Screen.dart';

class OptScreen extends StatefulWidget {
  final String email;
  const OptScreen({super.key, required this.email});

  @override
  _OptScreenState createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> otpControllers =
  List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  bool isLoading = false;

  @override
  void dispose() {
    for (final c in otpControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    String otpCode = otpControllers.map((controller) => controller.text).join();

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
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.verify}'),
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

        final token = data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
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
    double boxWidth = 13.w;
    double boxMargin = 1.5.w;

    return Container(
      width: boxWidth,
      height: 7.h,
      margin: EdgeInsets.symmetric(horizontal: boxMargin),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.9)),
      ),
      child: Center(
        child: TextField(
          controller: otpControllers[index],
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
                  text: 'Verification',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildOtpBox(index)),
              ),
              SizedBox(height: 5.h),
              TextButton(
                onPressed: () async {
                  if (widget.email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter your email")),
                    );
                    return;
                  }

                  final message =
                  await AuthService.resendEmail(email: widget.email);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message ?? "No response")),
                  );
                },
                child: Text('Resend Code', style: TextStyle(color: Colors.blue)),
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
