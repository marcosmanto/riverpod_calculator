import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_calculator/colors.dart';
import 'package:riverpod_calculator/widgets/button_widget.dart';

Future main() async {
  // Ensure flutter created the the binding with host platform
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the screen orientation to portrait. Only work with mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  static const String title = 'Calculator';

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        scrollBehavior: const MaterialScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.background1,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainPage(title: title),
      );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({super.key, required this.title});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final minWidth = 300.0;
  final _pageScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(widget.title),
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          controller: _pageScrollController,
          interactive: true,
          trackVisibility: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _pageScrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: max(screenWidth, minWidth)),
              child: Column(
                children: [
                  Expanded(child: buildResult()),
                  Expanded(flex: 2, child: buildButtons())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResult() => const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '0',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            SizedBox(height: 24),
            Text(
              '0',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 18),
            )
          ],
        ),
      );

  Widget buildButtons() => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: MyColors.background2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            buildButtonRow('AC', '<', '', '÷'),
            buildButtonRow('7', '8', '9', '⨯'),
            buildButtonRow('4', '5', '6', '-'),
            buildButtonRow('1', '2', '3', '+'),
            buildButtonRow('0', '.', '', '='),
          ],
        ),
      );

  Widget buildButtonRow(
    String first,
    String second,
    String third,
    String fourth,
  ) {
    final row = [first, second, third, fourth];

    return Expanded(
      child: Row(
        children: row
            .map(
              (text) => ButtonWidget(
                text: text,
                onClicked: () => print(text),
                onClickedLong: () => print(text),
              ),
            )
            .toList(),
      ),
    );
  }
}
