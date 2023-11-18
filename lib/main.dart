import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_calculator/colors.dart';

Future main() async {
  // Ensure flutter created the the binding with host platform
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the screen orientation to portrait. Only work with mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static const String title = 'Calculator';

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.background1,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'Hello',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
