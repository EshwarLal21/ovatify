import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ovatify/Helper/appColor.dart';
import 'package:ovatify/Helper/image_Class.dart';
import 'package:ovatify/View/explore_Screen.dart';
import 'package:ovatify/View/home_DetailScreen.dart';
import 'package:ovatify/View/myTrackConsumer_Screen.dart';
import 'package:ovatify/View/upload_Track_Screen.dart';
import 'package:ovatify/AiMusicCreation/createMusic.dart';
import 'package:ovatify/home/project/model/model.dart';
import 'package:ovatify/home/project/service/service.dart';
import 'package:ovatify/widget/btn_custumize.dart';
import 'package:ovatify/widget/text.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Project>> project = ProjectService.fetchProjects();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.title, scale: 6),
                      CustomLabelText(
                        text: 'Hey!',
                        color: AppColors.magenta,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                      CustomLabelText(
                        text: 'Ready to create?',
                        color: AppColors.white,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomLabelText(
                      text: 'Recent projects',
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ExploreScreen());
                      },
                      child: Icon(Icons.add, color: AppColors.primary),
                    ),
                    SizedBox(width: 4.w),
                  ],
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 18.h,
                  child: FutureBuilder<List<Project>>(
                    future: project,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading projects'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No projects found'));
                      }

                      final projects = snapshot.data!;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.project),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 30.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.3.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    child: Container(
                                      width: 30.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 8,
                                          sigmaY: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomLabelText(
                                              text: project.title,
                                              color: AppColors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            CustomLabelText(
                                              text:
                                                  'Last edited: ${project.formattedDate}',
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Inspiration Spotlight',
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 75.w,
                    child: Divider(
                      height: 1.h,
                      thickness: 2.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 30.w,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(AppImages.inspirationpic),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.h),
                            Image.asset(AppImages.islpb),
                            SizedBox(height: 1.h),
                            CustomLabelText(
                              text: 'Dark RnB',
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 1.h),
                            CustomButton(
                              title: 'Generate',
                              fontsize: 12.sp,
                              borderRadius: 10.sp,
                              backgroundColor: Colors.transparent,
                              borderColor: AppColors.white,
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform
                                        .pickFiles(type: FileType.audio);

                                if (result != null) {
                                  String filePath = result.files.single.path!;

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) =>
                                        Center(child: CircularProgressIndicator()),
                                  );

                                  await createAiMusicTrack(filePath: filePath);

                                  Navigator.pop(context); // Close loader

                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: Colors.black,
                                      title: Text("Success",
                                          style:
                                              TextStyle(color: Colors.green)),
                                      content: Text(
                                        "AI Music created and uploaded.",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("OK",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("File selection canceled"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              height: 3.5.h,
                              width: 24.w,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.darkgrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            Image.asset(AppImages.beatexpan),
                            SizedBox(height: 3.h),
                            CustomLabelText(
                              text: 'Beat Expansion',
                              color: AppColors.white,
                              fontSize: 14.sp,
                            ),
                            Text(
                              "Extend your rhythm in seconds",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.5.h),
                            CustomButton(
                              title: 'Expand Now',
                              fontsize: 14.sp,
                              borderRadius: 15.sp,
                              backgroundColor: AppColors.primary,
                              borderColor: AppColors.primary,
                              onPressed: () {
                                Get.to(() => MytrackconsumerScreen());
                              },
                              height: 5.h,
                              width: 34.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.darkgrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            Image.asset(AppImages.lyricsassist),
                            SizedBox(height: 3.h),
                            CustomLabelText(
                              text: 'Lyric Assistance',
                              color: AppColors.white,
                              fontSize: 14.sp,
                            ),
                            Text(
                              "Craft core ideas with AI partner",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.5.h),
                            CustomButton(
                              title: 'Start writing',
                              fontsize: 14.sp,
                              borderRadius: 15.sp,
                              backgroundColor: AppColors.primary,
                              borderColor: AppColors.primary,
                              onPressed: () {},
                              height: 5.h,
                              width: 34.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  title: 'Start a new project',
                  fontsize: 16.sp,
                  borderRadius: 15.sp,
                  backgroundColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  onPressed: () {
                    Get.to(() => UploadTrackScreen());
                  },
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
