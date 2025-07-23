import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/View/viewInvestmentDetail_Screen.dart';
import 'package:ovatify/View/viewTrackConsumer_Screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/text.dart';
import 'main_Screen.dart';

class InvestmentScreen extends StatefulWidget {
  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedChip = 'All Tracks';

  final List<String> chipLabels = ['All Tracks', 'Lorem', 'Ipsum'];
  final List<Map<String, String>> allTracks = List.generate(10, (index) => {
    'title': 'Cloudside',
    'artist': index % 2 == 0 ? 'Luna Beats' : 'Lorem',
    'price': '\$19',
    'tag': 'Family memories',
    'license': 'Licensed',
    'invested': '\$500.00',
    'expiresOn': 'Dec 15, 2026',
  });


  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTracks = selectedChip == 'All Tracks'
        ? allTracks
        : allTracks.where((track) => track['artist'] == selectedChip).toList();

    return SafeArea(
      child: Scaffold(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.title, scale: 6),
                      CustomLabelText(
                        text: 'Explore',
                        color: AppColors.magenta,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                      CustomLabelText(
                        text: 'Your Investments',
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: chipLabels.map((label) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              label,
                              style: TextStyle(
                                color: selectedChip == label
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
                              setState(() {
                                selectedChip = label;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 3.h),

                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelText(
                        text: 'Total Investment value',
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ), CustomLabelText(
                        text: 'Total Earnings',
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       CustomLabelText(
                        text: '\$120.00',
                        color: AppColors.white,
                        fontSize: 18.sp,
                      ), CustomLabelText(
                        text: '\$10.00',
                        color: AppColors.white,
                        fontSize: 18.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  Divider(height: 1.h,thickness: 0.3, color: Colors.grey,),
                  SizedBox(height: 4.h),

                  CustomLabelText(
                    text: 'Investments',
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),


                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTracks.length,
                    itemBuilder: (context, index) {
                      final track = filteredTracks[index];
                      return
                        GestureDetector(

                        onTap: (){
                          Get.to(() => ViewinvestmentdetailScreen());
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.black2,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 3.h,),
                                    CustomLabelText(
                                      text: 'Summer Vibes - By Luna beats' ?? '',
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                    CustomLabelText(
                                      text: 'Summer Vibes - By Luna beats' ?? '',
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 2.h),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomLabelText(
                                          text: "Smart Contract" ?? '',
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                        ),
                                        Row(
                                          children: [
                                            CustomLabelText(
                                              text: "05% " ?? '',
                                              color: AppColors.magenta,
                                              fontSize: 14.sp,
                                            ),
                                            CustomLabelText(
                                              text: "Ownership" ?? '',
                                              color: Colors.grey,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [
                                            CustomLabelText(
                                              text: "ROI: " ?? '',
                                              color: Colors.grey,

                                              fontSize: 14.sp,
                                            ),
                                            CustomLabelText(
                                              text: " 50%+" ?? '',
                                              color: AppColors.magenta,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CustomLabelText(
                                              text: "Total Invest: " ?? '',
                                              color: Colors.grey,

                                              fontSize: 14.sp,
                                            ),
                                            CustomLabelText(
                                              text: "\$500" ?? '',
                                              color: AppColors.magenta,
                                              fontSize: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
