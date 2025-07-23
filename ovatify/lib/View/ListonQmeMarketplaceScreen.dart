import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/alertbox.dart';
import '../widget/btn_custumize.dart';
import '../widget/input_field.dart';
import '../widget/text.dart';
import 'main_Screen.dart';

class Listonqmemarketplacescreen extends StatefulWidget {
  @override
  _ListonqmemarketplacescreenState createState() =>
      _ListonqmemarketplacescreenState();
}

class _ListonqmemarketplacescreenState
    extends State<Listonqmemarketplacescreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController shortDesController = TextEditingController();

  String selectedChip = 'All';
  final List<String> chipLabels = ['All', 'Loops', 'Loops', 'Drums'];

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
    );
  }

  Future<void> listTrack() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = 'https://ovatify.betfastwallet.com/api/user/my/track/store'; // Replace with actual API endpoint

    final Map<String, dynamic> body = {
      "name": nameController.text.trim(),
      "price": double.tryParse(priceController.text.trim()) ?? 0.0,
      "description": shortDesController.text.trim(),
      "genre": selectedChip,
      "ai_music_id": 2, // This can be dynamic if needed
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        showCustomDialog(
          context: context,
          title: 'Your Track Is Live!',
          image: AppImages.done,
          contentText:
              'Your track has been successfully listed on QmeMarketplace!',
          showLoader: false,
          autoClose: false,
          button1Text: 'View on Marketplace',
          onButton1Pressed: () {
            Navigator.pop(context);
          },
          button2Text: 'Back to My Tracks',
          onButton2Pressed: () {
            Navigator.pop(context);
          },
          btn1bgcolor: AppColors.primary,
          btn1txtcolor: AppColors.white,
          btn1bordercolor: Colors.transparent,
          btn2bgcolor: AppColors.darkgrey,
          btn2txtcolor: AppColors.white,
          btn2bordercolor: AppColors.primary,
        );
      } else {
        print(
          "Failed to list track: \${response.statusCode} | \${response.body}",
        );
      }
    } catch (e) {
      print("Exception: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.center,
                  child: CustomLabelText(
                    text: 'List on QmeMarketplace',
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),

                CustomLabelText(
                  text: 'Track Name',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CustomFormTextField(
                  label: 'Track Name',
                  controller: nameController,
                ),

                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Price',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CustomFormTextField(
                  label: '\$00.00',
                  controller: priceController,
                ),

                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Short Description',
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                CustomFormTextField(
                  label: 'Write your description',
                  controller: shortDesController,
                  maxLines: 6,
                ),

                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Genre Tags',
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 3.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        chipLabels
                            .map(
                              (label) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(
                                    label,
                                    style: TextStyle(
                                      color:
                                          selectedChip == label
                                              ? Colors.white
                                              : AppColors.primary,
                                    ),
                                  ),
                                  selected: selectedChip == label,
                                  showCheckmark: false,
                                  backgroundColor: Colors.black,
                                  selectedColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: AppColors.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                  onSelected: (bool selected) {
                                    setState(() => selectedChip = label);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),

                SizedBox(height: 2.h),
                Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: AppColors.black2,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AppImages.islpb),
                      Image.asset(AppImages.waves),
                      CustomLabelText(
                        text: '02:00',
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),
                Divider(height: 1.h, thickness: .03.h),
                SizedBox(height: 2.h),

                CustomButton(
                  title: 'List Now',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      listTrack();
                    }
                  },
                  backgroundColor: AppColors.primary,
                  borderColor: Colors.transparent,
                ),

                SizedBox(height: 2.h),
                CustomButton(
                  title: 'Back to My Tracks',
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.grey,
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
