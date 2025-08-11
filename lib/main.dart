import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/utils/shared_prefs_helper.dart';
import 'package:note_app/presintation/screens/login_screen.dart';
import 'package:note_app/presintation/screens/notes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  await SharedPrefsHelper.init();

  final languageCode = await SharedPrefsHelper.getLocale();


  runApp(
    EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          startLocale: languageCode != null ? Locale(languageCode) : const Locale('en'),
          child: const MyApp()
      ),
  );
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SharedPrefsHelper.getIsLoggedIn() ? NotesScreen() : LoginScreen(),
    );
  }
}
