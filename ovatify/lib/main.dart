import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ovatify/View/ApplyforJob_Screen.dart';
import 'package:ovatify/View/List_Tracker_Screen.dart';
import 'package:ovatify/View/ListonQmeMarketplaceScreen.dart';
import 'package:ovatify/View/QmeJobHub_Screen.dart';
import 'package:ovatify/View/RightsManagement_Screen.dart';
import 'package:ovatify/View/home_Screen.dart';
import 'package:ovatify/View/investInTrack_Screen.dart';
import 'package:ovatify/View/job_DetailsScreen.dart';
import 'package:ovatify/View/marketing_Screen.dart';
import 'package:ovatify/View/me_Screen.dart';
import 'package:ovatify/View/myTrackConsumer_Screen.dart';
import 'package:ovatify/View/mytracks_Screen.dart';
import 'package:ovatify/View/trackMetadata_Screen.dart';
import 'package:ovatify/View/upload_Track_Screen.dart';
import 'package:ovatify/View/viewTrackConsumer_Screen.dart';
import 'package:ovatify/View/view_MarketingDetailsScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ovatify/View/profilescreen.dart';
import 'View/AiMusicListScreen.dart';
import 'View/Auth/facebook_login.dart';
import 'View/Auth/google_login.dart';
import 'View/Auth/login_Screen.dart';
import 'View/explore_Screen.dart';
import 'View/home_DetailScreen.dart';
import 'View/investment_Screen.dart';
import 'View/main_Screen.dart';
import 'View/viewInvestmentDetail_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  // Run your app
  runApp(MyApp(token: token));
}


class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(

        builder: (context, orientation, screenType) {

        return GetMaterialApp(
          title: 'Ovatify',
          debugShowCheckedModeBanner: false
          ,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
            // home: JobDetailsscreen(),
            home: token == null ? LoginScreen(): MyHomePage()  ,
        );
      }
    );
  }
}


