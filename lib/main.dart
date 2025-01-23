
import 'package:eunice_app/Utils/utils.dart';
import 'package:eunice_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

bool homeOrLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(
      MyApp(loggeado: homeOrLogin ? true : false, homePage: HomePage()));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  bool loggeado;
  Widget homePage;
  MyApp({super.key, required this.loggeado, required this.homePage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.oswaldTextTheme(),
      ),
      enableLog: true,
      locale: const Locale('es', 'ES'),
      supportedLocales: const [
        Locale('es', 'ES'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "Eunice App",
      builder: (context, child) {
        return Container(
          color: Utils.primaryColor,
          child: SafeArea(
            child: child!,
          ),
        );
      },
      initialRoute: HomePage.route,
      getPages: [
        GetPage(name: HomePage.route, page: () => HomePage()),
      ],
    );
  }
}
