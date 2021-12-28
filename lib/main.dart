import 'package:flutter/material.dart';
import 'package:personal_folio/topbar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    if (isWebMobile) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return MaterialApp(
      title: 'Pratik Bedre',
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int curInex = 0;

  final PageController controller = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget coloredContainer({context, color, Key? key}) {
    return Container(
        color: color,
        key: key,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width);
  }

  @override
  Widget build(BuildContext context) {
    List<GlobalKey> keys = [GlobalKey(), GlobalKey(), GlobalKey()];
    List<Widget> children = [
      TopBar(key: keys[0]),
      coloredContainer(key: keys[1], color: Colors.redAccent, context: context),
      coloredContainer(
          key: keys[2], color: Colors.blueAccent, context: context),
    ];
    ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: curInex,
          onTap: (mi) => setState(() {
            curInex = mi;
            controller.animateToPage(mi,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          }),
          items: const [
            BottomNavigationBarItem(
                label: 'About',
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "Experience",
                icon: Icon(
                  Icons.work,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "Projects",
                icon: Icon(
                  Icons.code,
                  color: Colors.black,
                ))
          ],
        ),
        floatingActionButton: ExpandingFAB(isDialOpen: isDialOpen),
        body: PageView(
          physics: const ClampingScrollPhysics(),
          onPageChanged: (int page) {
            setState(() {
              if (page < children.length) curInex = page;
            });
          },
          controller: controller,
          scrollDirection: Axis.vertical,
          children: children,
        ));
  }
}

class ExpandingFAB extends StatelessWidget {
  const ExpandingFAB({
    Key? key,
    required this.isDialOpen,
  }) : super(key: key);

  final ValueNotifier<bool> isDialOpen;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      openCloseDial: isDialOpen,
      icon: Icons.connect_without_contact_sharp,
      activeIcon: Icons.close,
      backgroundColor: Colors.cyan[200],
      overlayColor: Colors.grey,
      overlayOpacity: 0.5,
      spacing: 15,
      spaceBetweenChildren: 15,
      closeManually: true,
      children: [
        SpeedDialChild(
          onTap: () {
            launch('https://www.github.com/pratikb2805');
          },
          child: const Icon(FontAwesomeIcons.github),
        ),
        SpeedDialChild(
          onTap: () {
            launch('https://linkedin.com/in/pratikbedre');
          },
          child: const Icon(FontAwesomeIcons.linkedin),
        ),
        SpeedDialChild(
          onTap: () {
            final mailtoLink = Mailto(
              to: ['pratikb.2805@gmail.com'],
            );
            // Convert the Mailto instance into a string.
            // Use either Dart's string
            // interpolation
            // or the toString() method.
            launch('$mailtoLink');
          },
          child: const Icon(FontAwesomeIcons.at),
        )
      ],
    );
  }
}
