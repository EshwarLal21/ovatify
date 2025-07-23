import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ovatify/Helper/appColor.dart';
import 'package:ovatify/Helper/image_Class.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'investInTrack_Screen.dart';
import 'job_DetailsScreen.dart';

class QmejobhubScreen extends StatefulWidget {
  @override
  State<QmejobhubScreen> createState() => _QmejobhubScreenState();
}

class _QmejobhubScreenState extends State<QmejobhubScreen> {
  final artistPercentageController = TextEditingController();

  final labelPercentageController = TextEditingController();

  final paymentMethodController = TextEditingController();

  final durationController = TextEditingController();

  final dateController = TextEditingController();

  String selectedChip = 'All';

  final List<String> chipLabels = ['All', 'Loops', 'Loops', 'Drums'];
  final List<Map<String, String>> allTracks = List.generate(10, (index) => {
    'title': 'Cloudside',
    'artist': index % 2 == 0 ? 'Luna Beats' : 'Lorem',
    'price': '\$19',
    'tag': 'Family memories',
    'license': 'Licensed',
    'invested': '\$500.00',
    'expiresOn': 'Dec 15, 2026',
  });

  @override
  Widget build(BuildContext context) {
    final filteredTracks = selectedChip == 'All Tracks'
        ? allTracks
        : allTracks.where((track) => track['artist'] == selectedChip).toList();
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomLabelText(
          text: 'Standard Artist Agreement',
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
              text: 'QmeJobHub',
              color: AppColors.magenta,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 1.h),
            CustomLabelText(
              text: 'Find or post gigs',
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 1.h),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                Row(
                  children: chipLabels
                      .map(
                        (label) => Padding(
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
                    ),
                  )
                      .toList(),
                )

            ),

            SizedBox(height: 2.h),

             Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(12),
                 
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),

                            SizedBox(width: 4.w),
                            Column(
                              children: [
                                CustomLabelText(
                                  text: 'Luna Beats',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                CustomLabelText(
                                  text: 'Pop music expert',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomLabelText(
                          text: '9h ago' ?? '',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            CustomLabelText(
                              text: "Salary: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: " \$300-500" ?? '',
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomLabelText(
                              text: "Tags: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: "Mixing Pop FL Studi" ?? '',
                              color:  Colors.grey,
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
             Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(12),
                 
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),

                            SizedBox(width: 4.w),
                            Column(
                              children: [
                                CustomLabelText(
                                  text: 'Luna Beats',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                CustomLabelText(
                                  text: 'Pop music expert',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomLabelText(
                          text: '9h ago' ?? '',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            CustomLabelText(
                              text: "Salary: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: " \$300-500" ?? '',
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomLabelText(
                              text: "Tags: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: "Mixing Pop FL Studi" ?? '',
                              color:  Colors.grey,
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
             Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(12),
                 
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),

                            SizedBox(width: 4.w),
                            Column(
                              children: [
                                CustomLabelText(
                                  text: 'Luna Beats',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                CustomLabelText(
                                  text: 'Pop music expert',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomLabelText(
                          text: '9h ago' ?? '',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            CustomLabelText(
                              text: "Salary: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: " \$300-500" ?? '',
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomLabelText(
                              text: "Tags: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: "Mixing Pop FL Studi" ?? '',
                              color:  Colors.grey,
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
             Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(12),
                 
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),

                            SizedBox(width: 4.w),
                            Column(
                              children: [
                                CustomLabelText(
                                  text: 'Luna Beats',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                CustomLabelText(
                                  text: 'Pop music expert',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomLabelText(
                          text: '9h ago' ?? '',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            CustomLabelText(
                              text: "Salary: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: " \$300-500" ?? '',
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomLabelText(
                              text: "Tags: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: "Mixing Pop FL Studi" ?? '',
                              color:  Colors.grey,
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
             Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppColors.black2,
                borderRadius: BorderRadius.circular(12),
                 
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),

                            SizedBox(width: 4.w),
                            Column(
                              children: [
                                CustomLabelText(
                                  text: 'Luna Beats',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                                CustomLabelText(
                                  text: 'Pop music expert',
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomLabelText(
                          text: '9h ago' ?? '',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            CustomLabelText(
                              text: "Salary: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: " \$300-500" ?? '',
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomLabelText(
                              text: "Tags: " ?? '',
                              color: Colors.white,

                              fontSize: 14.sp,
                            ),
                            CustomLabelText(
                              text: "Mixing Pop FL Studi" ?? '',
                              color:  Colors.grey,
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

            SizedBox(height: 10.h,),
            CustomButton(title: 'Post a Job', onPressed: () {
              Get.to(() => JobDetailsscreen());
              // showCustomDialog(
              //   context: context,
              //   title: 'Purchase Successful',
              //   image: AppImages.done,
              //   contentText: 'Your track is now available in your library!',
              //   showLoader: false,
              //   autoClose: false,
              //   button1Text: 'Go to My Tracks',
              //   onButton1Pressed: () {
              //     // Navigate to tracks page
              //     Navigator.pushNamed(context, '/my-tracks');
              //   },
              //   button2Text: 'Explore more music',
              //   onButton2Pressed: () {
              //     // Navigate to music explore page
              //     Navigator.pushNamed(context, '/explore');
              //   },
              //   btn1bgcolor: AppColors.primary,
              //   btn1txtcolor: AppColors.white,
              //   btn1bordercolor: Colors.transparent,
              //   btn2bgcolor: AppColors.darkgrey,
              //   btn2txtcolor: AppColors.white,
              //   btn2bordercolor: AppColors.primary,
              // );


            },),
            SizedBox(height: 2.h,),
            CustomButton(
              title: 'Back to Marketplace',
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
