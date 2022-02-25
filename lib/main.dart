//import 'package:fanpage_app/splash.dart';
import 'package:fanpage_app/providers/user_provider.dart';
import 'package:fanpage_app/responsive/mobileScreenLayout.dart';
import 'package:fanpage_app/responsive/responsive_layout_screen.dart';
import 'package:fanpage_app/responsive/webScreenLayout.dart';
import 'package:fanpage_app/screens/login_screen.dart';
import 'package:fanpage_app/screens/splashscreen.dart';
import 'package:fanpage_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: " AIzaSyAcAiPUk5pid2YTMR4Ygu_Y9AB-EnClr-8",
          appId: "1:968169981921:web:56489dbc5eb36226b074a0",
          messagingSenderId: "G-H59YMXSCEV",
          projectId: "fanpage-66efc",
          storageBucket: "fanpage-66efc.appspot.com"),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
   child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FanPage',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (contelxt, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Interanl Error'));
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const SplashScreen();
        },
      ),
    )
    );
  }
}
