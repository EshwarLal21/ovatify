import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ovatify/Helper/appColor.dart';
import 'package:ovatify/Helper/image_Class.dart';
import '../widget/text.dart';
import 'investInTrack_Screen.dart';

class ArtistAgreementScreen extends StatelessWidget {
  final artistPercentageController = TextEditingController();
  final labelPercentageController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final durationController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomLabelText(
                    text: 'Standard Artist  \n Agreement',
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(() =>InvestintrackScreen());
                  },
                  child: Container(

                    padding: EdgeInsets.all(8),
                    child: Image.asset(AppImages.download1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),

            CustomLabelText(
              text: 'Category: Artist      Type: Legal Agreement',
              color: Colors.white54,
              fontSize: 14.sp,
            ),
            SizedBox(height: 2.h),

            sectionTitle("1. Grant of Rights"),
            sectionBody(
              "The Artist grants the Producer/Label the non-exclusive right to record, distribute, and promote the musical works created under this agreement.",
            ),

            sectionTitle("2. Compensation & Royalties"),

            CustomLabelText(text:"Royalties shall be split as follows", color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,),
            CustomLabelText(text:" .  Artist: [Insert %]",  color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,),
            CustomLabelText(text:" .  Producer/Label: [Insert %] Payments will be made \n    quarterly via [Preferred Payment Method]", color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,),

            sectionTitle("3. Ownership & Copyright"),
            sectionBody(
              "The copyright of the composition and master recording will be shared equally unless otherwise stated in writing.",
            ),

            sectionTitle("4. Creative Control"),
            sectionBody(
              "Both parties agree to maintain open communication regarding changes, releases, or public performances.",
            ),

            sectionTitle("5. Term & Termination"),
            sectionBody(
              "This agreement is valid for [Insert Duration], and either party may terminate it with a 30-day written notice.",
            ),


            sectionTitle("6. Signatures"),
            sectionBody(
              "By signing below, both parties agree to the terms outlined above.",
            ),

            SizedBox(height: 3.h),
            sectionBody(
              "   Artist Signature: ______________________",
            ), sectionBody(
              "   Producer/Label Signature: ____________________",
            ), sectionBody(
              "   Date: ____________________",
            ),

          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 6),
      child: CustomLabelText(
        text: title,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget sectionBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CustomLabelText(
        text: text,
        color: Colors.white70,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget customInput(String label, TextEditingController? controller, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabelText(
            text: '$label:',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white54),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
