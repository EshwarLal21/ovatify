import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ovatify/Helper/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Helper/image_Class.dart';
import '../widget/iconbtn_custusmize.dart';
import '../widget/text.dart';
import 'Standard_ArtistScreen.dart'; // Assuming you have this widget

class RightsmanagementScreen extends StatefulWidget {
  @override
  _RightsmanagementScreenState createState() => _RightsmanagementScreenState();
}

class _RightsmanagementScreenState extends State<RightsmanagementScreen> {
  int _selectedIndex = 0;
  final List<String> projectOptions = ['Lorem', 'Lorem', 'Ipsum', 'Ipsum'];
  String selectedProject = 'Lorem';

  final List<Map<String, dynamic>> collaborators = [
    {'name': 'Alice Smith', 'roles': ['Artist']},
    {'name': 'John Doe', 'roles': ['Producer']},
  ];

  final Map<String, double> share = {
    'Alice Smith': 50,
    'John Doe': 50,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildRoleSelector(List<String> roles) {
    final allRoles = ['Artist', 'Producer', 'Writer'];
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: allRoles.map((role) {
        final isSelected = roles.contains(role);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                roles.remove(role);
              } else {
                roles.add(role);
              }
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
                text: role,
                color: Colors.white,
                fontSize: 16,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 5.h),
            CustomLabelText(
              text: 'Choose the project',
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 1.h),
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
            SizedBox(height: 3.h),
            Divider(height: 0.1.h, thickness: 0.03.h, color: Colors.grey),
            SizedBox(height: 2.h),
            CustomLabelText(text: 'Rights ', color: AppColors.magenta, fontSize: 18.sp),
            CustomLabelText(text: 'Management Dashboard', color: Colors.white, fontSize: 18.sp),
            SizedBox(height: 3.h),

            CustomLabelText(text: 'Collaborators', color: Colors.white, fontSize: 18.sp),
            ...collaborators.map((collab) => Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomLabelText(text: collab['name'], color: Colors.white, fontSize: 17.sp),
                  buildRoleSelector(collab['roles']),
                ],
              ),
            )),

            SizedBox(height: 3.h),
            Align(alignment :Alignment.center,
                child: CustomLabelText(text: 'See Who Gets What', color: Colors.white, fontSize: 18.sp)),

            SizedBox(height: 250, child: buildPieChart()),
            ...share.entries.map((e) => Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: e.key == 'Alice Smith' ? AppColors.pinkchart : AppColors.bluechart,
                    shape: BoxShape.circle,
                  ),
                ),
                CustomLabelText(
                  text: "${e.key} is getting ${e.value.toInt()}%",
                  color: Colors.white,
                ),
              ],
            )),

            SizedBox(height: 3.h),
            CustomLabelText(text: 'Agreement Templates', color: Colors.white, fontSize: 18.sp),

            Column(
              children: [
                ...[
                  "Standard Artist Agreement",
                  "Producer Agreement",
                  "Collaboration Contract",
                  "Publishing Split Sheet"
                ].map((title) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      title: CustomLabelText(
                        text: title,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16),
                      tileColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      dense: false,
                      onTap: () {},
                    ),
                  );
                }).toList(),
              ],
            ),


            SizedBox(height: 2.h),
            CustomIconButton(title: 'Upload Creator \n Template', onPressed: () {

              Get.to(() => ArtistAgreementScreen());
            },
              assetPath: AppImages.downloadU,
              backgroundColor: Colors.grey.withOpacity(0.1),
              textColor: Colors.white,
              borderColor: Colors.grey.withOpacity(0.1),
              borderRadius: 12.0,
              height: 70.0,
              width: double.infinity,
              iconPosition: IconPosition.right,

            ),
            SizedBox(height: 5.h),

          ],
        ),
      ),
    );
  }

  Widget buildPieChart() {
    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        sections: [

          PieChartSectionData(
            color: AppColors.bluechart,
            value: share['John Doe']!,
            title: '',
            radius: 50,
          ),
          PieChartSectionData(
            color: AppColors.pinkchart,
            value: share['Alice Smith']!,
            title: '',
            radius: 50,
          ),
        ],
        centerSpaceRadius: 50,
        sectionsSpace: 2,
      ),
    );
  }
}