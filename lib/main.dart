import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isntagram/Screens/login_screen.dart';
import 'package:isntagram/Screens/signup_screen.dart';
import 'package:isntagram/providers/user_provider.dart';
import 'package:isntagram/responsive/mobile_screen_layout.dart';
import 'package:isntagram/responsive/responsive_layout_screen.dart';
import 'package:isntagram/responsive/web_screen_layout.dart';
import 'package:isntagram/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize widgets before initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  // check whether the app is running on web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCH0SgpfECQ-YWeDWnoDgjMo0_1r28_aiY",
        appId: "1:881923422061:web:e357888994b91250fd0c64",
        messagingSenderId: "881923422061",
        projectId: "instagram-flutter-7b2f6",
        storageBucket: "instagram-flutter-7b2f6.appspot.com",
      ),
    );
  } else {
// initialize firebase for ios & android
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // wrap with a provider
    return MultiProvider(
        // lis of providers
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram',
          // app theme
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          // state management
          home: StreamBuilder(
            // authStateChanges runs when user signs in or out.
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // check snapshot is active
              if (snapshot.connectionState == ConnectionState.active) {
                // check whether snapshot has data
                if (snapshot.hasData) {
                  // return responsive layout
                  return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                // snapshot is not active and is waiting
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
              }
              // if the snapshot is active but has no data, the show login screen
              // meaning the user is not authenticated
              return const LoginScreen();
            },
          ),
        ));
  }
}
