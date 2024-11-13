import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil_seekers/app_theme.dart';
import 'package:green_oil_seekers/sign_in_screen/sign_in_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (fn) {
      runApp(const App());
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: const SignInScreen(),
    );
  }
}
