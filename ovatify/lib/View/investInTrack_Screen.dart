import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ovatify/Helper/appColor.dart';
import 'package:ovatify/Helper/image_Class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/apiHelper.dart';
import '../widget/alertbox.dart';
import '../widget/btn_custumize.dart';
import '../widget/input_field.dart';
import '../widget/text.dart';

class InvestintrackScreen extends StatefulWidget {
  @override
  State<InvestintrackScreen> createState() => _InvestintrackScreenState();
}

class _InvestintrackScreenState extends State<InvestintrackScreen> {
  final nameController = TextEditingController();

  final cardController = TextEditingController();

  final expirydateController = TextEditingController();

  final cvvController = TextEditingController();

  bool isRemember = false;
  bool isLoading = false;

  Future<void> handlePurchaseTrack() async {
    final name = nameController.text.trim();
    final cardNo = cardController.text.trim();
    final expiry = expirydateController.text.trim();
    final cvv = cvvController.text.trim();

    if (name.isEmpty || cardNo.isEmpty || expiry.isEmpty || cvv.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill in all fields"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // Adjust key if needed

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final body = {
        "name": name,
        "card_no": cardNo,
        "expiry": expiry,
        "cvv": cvv,
        "track_id": 1, // Replace with dynamic track ID if needed
      };

      final response = await ApiService.post('/purchase/track', body: body, headers: headers);
      print(response.statusCode);
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() => isLoading = false);

      if (response.statusCode == 200 && responseData['success'] == true) {
        showCustomDialog(
          context: context,
          title: 'Purchase Successful',
          image: AppImages.done,
          contentText: 'Your track is now available in your library!',
          showLoader: false,
          autoClose: false,
          button1Text: 'Go to My Tracks',
          onButton1Pressed: () {
            Navigator.pop(context);
            // Navigate to library screen here
          },
          button2Text: 'Explore more music',
          onButton2Pressed: () {
            Navigator.pop(context);
            // Navigate to explore screen
          },
          btn1bgcolor: AppColors.primary,
          btn1txtcolor: AppColors.white,
          btn1bordercolor: Colors.transparent,
          btn2bgcolor: AppColors.darkgrey,
          btn2txtcolor: AppColors.white,
          btn2bordercolor: AppColors.primary,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData['message'] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      setState(() => isLoading = false);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,

        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomLabelText(

          text: 'Invest in Track',
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomLabelText(
              text: 'Order Summary',
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 1.h),


            SizedBox(height: 2.h),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 12.h,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColors.darkgrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            AppImages.inspirationpic,
                            // scale: 4,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.7.h,),

                              Text("Night Vibes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                              SizedBox(height: 1.7.h,),

                              Text("By Alex M.", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                              SizedBox(height: 1.h,),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Text("\$29.00 ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      SizedBox(width: 5.w,),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
            Divider(height: 1.h,thickness: 0.2.h,color: AppColors.darkgrey,),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLabelText(
                  text: 'Subtotal',
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomLabelText(
                  text: '\$29.00',
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],),
            SizedBox(height: 4.h),
            CustomFormTextField(label: 'Name', controller: nameController,),
            SizedBox(height: 2.5.h),
            CustomFormTextField(label: 'Credit Card No', controller: cardController,),
            SizedBox(height: 2.5.h),

            Row(
              children: [
                Expanded(child: CustomFormTextField(label: 'Expiry', controller: expirydateController,)),
                SizedBox(width: 4.w,),
                Expanded(child: CustomFormTextField(label: 'Cvv', controller: cvvController,)),

              ],
            ),
            SizedBox(height: 1.5.h),
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
                    text: 'Save card for future purchases',
                    color: AppColors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            CustomButton(title: isLoading?'processing...':'Confirm & Pay', onPressed: () {
              isLoading ? null : handlePurchaseTrack();

              showCustomDialog(
                context: context,
                title: 'Purchase Successful',
                image: AppImages.done,
                contentText: 'Your track is now available in your library!',
                showLoader: false,
                autoClose: false,
                button1Text: 'Go to My Tracks',
                onButton1Pressed: () {
                },
                button2Text: 'Explore more music',
                onButton2Pressed: () {
                },
                btn1bgcolor: AppColors.primary,
                btn1txtcolor: AppColors.white,
                btn1bordercolor: Colors.transparent,
                btn2bgcolor: AppColors.darkgrey,
                btn2txtcolor: AppColors.white,
                btn2bordercolor: AppColors.primary,
              );


            },),
            SizedBox(height: 2.h,),
            CustomButton(
              title: 'Back to track',
              onPressed: () {  },
              backgroundColor: AppColors.black,
              borderColor: Colors.grey,),
            SizedBox(height: 3.h,),





          ],
        ),
      ),
    );
  }
}
