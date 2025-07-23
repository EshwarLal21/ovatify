
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/data/apiConstants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/appColor.dart';
import '../Helper/image_Class.dart';
import '../widget/alertbox.dart';
import '../widget/btn_custumize.dart';
import '../widget/input_field.dart';
import '../widget/text.dart';
import 'Standard_ArtistScreen.dart';
import 'home_Screen.dart';
import 'main_Screen.dart';

class ApplyforjobScreen extends StatefulWidget {
  final String title;
  final String email;
  final String price;

  const ApplyforjobScreen({super.key, required this.title, required this.email, required this.price});

  @override
  _ApplyforjobScreenState createState() => _ApplyforjobScreenState();
}

class _ApplyforjobScreenState extends State<ApplyforjobScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  final TextEditingController nameController = TextEditingController();

  void _onItemTapped(int index) {
    // if (index == 2) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

  TextEditingController messageController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isBullet = false;
  bool isNumbered = false;

  void applyFormatting() {
    final selection = _controller.selection;
    final text = _controller.text;
    final selectedText = selection.textInside(text);

    String formatted = selectedText;

    if (isBold) formatted = '**$formatted**';
    // if (isItalic) formatted = '_$formatted_';
    if (isBullet) formatted = '• $formatted';
    if (isNumbered) formatted = '1. $formatted';

    final newText = text.replaceRange(selection.start, selection.end, formatted);

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + formatted.length),
    );
  }
  Future<void> submitJobApplication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('${ApiConstants.baseUrl}/apply/job'); // replace with your real API

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = json.encode({
      "job_id": 2,
      "name": nameController.text.trim(),
      "role": selectedProject,
      "cover_latter": _controller.text.trim(),
    });

    final response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        showCustomDialog(
          context: context,
          title: 'Application Submitted!',
          image: AppImages.done,
          contentText: 'The job poster will review it shortly!',
          showLoader: false,
          autoClose: false,
          button1Text: 'Back to Jobs',
          onButton1Pressed: () => Navigator.pop(context),
          button2Text: 'Review Job',
          onButton2Pressed: () => Navigator.pop(context),
          btn1bgcolor: AppColors.primary,
          btn1txtcolor: AppColors.white,
          btn1bordercolor: Colors.transparent,
          btn2bgcolor: AppColors.darkgrey,
          btn2txtcolor: AppColors.white,
          btn2bordercolor: AppColors.primary,
        );
      } else {
        showErrorDialog(responseData['message'].toString());
      }
    } else {
      showErrorDialog('Something went wrong. Please try again.');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("Error", style: TextStyle(color: Colors.red)),
        content: Text(message, style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            child: Text("OK", style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _controller.text = '''
1. Grant of Rights
The Artist grants the Project/Label the non-exclusive right to exploit and distribute the master and composition created under this agreement.

2. Compensation & Royalties
Royalties shall be split as follows:
• Artist: 50%
• Project/Label: 50%
Payments processed quarterly via Preferred Payment Method.

3. Ownership & Copyright
The Artist owns the composition and master recording. Project/Label shall obtain usage licenses where applicable.

4. Creative Control
Both parties agree to maintain open communication and final approval rights.

5. Terms & Termination
This agreement is valid for a set duration and may be terminated with written notice 30 days in advance.

6. Signatures
By signing below, both parties agree to the terms outlined above.
''';
  }
  final List<String> projectOptions = ['Lorem', 'Lorem', 'Ipsum', 'Ipsum'];
  String selectedProject = 'Lorem';
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                    text: 'Apply for Job',
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 2.h),

                CustomLabelText(
                  text: widget.title,
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),

                SizedBox(height: 2.h),

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
                              text: widget.email,
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
                      text: widget.price,
                      color: AppColors.white,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ],
                ),


                SizedBox(height: 2.h,),

                Divider(height: 0.1.h, thickness: 0.03.h),
                SizedBox(height: 2.h,),

                CustomLabelText(
                  text: 'Your Name',
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 2.h),
                CustomFormTextField(label: 'Name', controller: nameController,),


                SizedBox(height: 2.h),
                CustomLabelText(
                  text: 'Your Name',
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 1.h,),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: projectOptions.map((project) {
                    final isSelected = selectedProject == project;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedProject = project;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary),
                              color: isSelected ? AppColors.primary : Colors.transparent,
                            ),
                            child: isSelected
                                ? Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                                : null,
                          ),
                          SizedBox(width: 8),
                          CustomLabelText(
                            text: project,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 4.h),
                CustomLabelText(
                  text: 'Write Cover message',
                  color: AppColors.white,
                  fontSize: 18.sp,
                ),
                SizedBox(height: 2.h,),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.format_bold, color: isBold ? Colors.blue : Colors.white),
                            onPressed: () => setState(() => isBold = !isBold),
                          ),
                          IconButton(
                            icon: Icon(Icons.format_italic, color: isItalic ? Colors.blue : Colors.white),
                            onPressed: () => setState(() => isItalic = !isItalic),
                          ),
                          IconButton(
                            icon: Icon(Icons.format_list_bulleted, color: isBullet ? Colors.blue : Colors.white),
                            onPressed: () => setState(() => isBullet = !isBullet),
                          ),
                          IconButton(
                            icon: Icon(Icons.format_list_numbered, color: isNumbered ? Colors.blue : Colors.white),
                            onPressed: () => setState(() => isNumbered = !isNumbered),
                          ),
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: applyFormatting,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      Container(
                        height: 300,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration.collapsed(
                            hintText: "Write or edit agreement...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),





                SizedBox(height: 8.h),
                CustomButton(title: 'Submit Application', onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    await submitJobApplication();
                  }
                  showCustomDialog(
                    context: context,
                    title: 'Application Submitted!',
                    image: AppImages.done,
                    contentText: 'The job poster will review it shortly!',
                    showLoader: false,
                    autoClose: false,
                    button1Text: 'Back to Jobs',
                    onButton1Pressed: () {
                      Navigator.pop(context);
                    },
                    button2Text: 'Review Job',
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
                },),

                SizedBox(height: 3.h),

              ],
            ),
          ),
        ),
      ),



    );
  }
}


