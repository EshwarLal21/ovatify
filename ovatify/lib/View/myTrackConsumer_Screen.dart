
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/View/viewTrackConsumer_Screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/text.dart';
import 'main_Screen.dart';

class MytrackconsumerScreen extends StatefulWidget {
  @override
  _MytrackconsumerScreenState createState() => _MytrackconsumerScreenState();
}

class _MytrackconsumerScreenState extends State<MytrackconsumerScreen> {
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
                  // SizedBox(height: 6.h),
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
                        text: 'Your Tracks',
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTracks.length,
                    itemBuilder: (context, index) {
                      final track = filteredTracks[index];
                      return GestureDetector(

                       onTap: (){
                         Get.to(() => ViewtrackconsumerScreen());
                       },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.black2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all( Radius.circular(15)),
                                      child: Image.asset(
                                        AppImages.inspirationpic,
                                        height: 14.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(

                                    child: Image.asset(AppImages.islpb),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(AppImages.profile),
                                        ),
                                        SizedBox(width: 10),
                                        CustomLabelText(
                                          text: track['artist'] ?? '',
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.h),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomLabelText(
                                          text: track['tag'] ?? '',
                                          color: AppColors.white,
                                        ),
                                        Image.asset(AppImages.downloadS),
                                      ],
                                    ),
                                    SizedBox(height: 3.h),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomLabelText(
                                          text: 'Expires on: ${track['expiresOn'] ?? ''}',
                                          color: Colors.grey,
                                          fontSize: 14.sp,

                                        ),
                                        CustomLabelText(
                                          text: 'Invested: ${track['invested'] ?? ''}',
                                          color: Colors.grey,
                                          fontSize: 14.sp,

                                        ),
                                        SizedBox(height: 1.3.h),

                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade500,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: CustomLabelText(
                                            text: track['license'] ?? '',
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                          ),
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
