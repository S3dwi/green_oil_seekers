import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil_seekers/choose_city.dart'; // Import the new screen here

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  primaryColor: const Color(0xFF47AB4D),
);

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
      theme: theme,
      themeMode: ThemeMode.system,
      // Set initial route to HomeScreen
      home: const ChooseCityScreen(),
    );
  }
}
