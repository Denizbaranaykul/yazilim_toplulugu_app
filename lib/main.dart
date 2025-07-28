import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/main_page/bottom_navigationbar.dart';
import 'package:yazilim_toplulugu_app/pages/events_page.dart';
import 'package:yazilim_toplulugu_app/pages/main_page.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yazilim_toplulugu_app/service/Auth_gate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class Main_page extends StatefulWidget {
  const Main_page({super.key});

  @override
  State<Main_page> createState() => _Main_pageState();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(), // yönlendirmeyi burada yapacağız
    );
  }
}

class _Main_pageState extends State<Main_page> {
  int currentIndex = 0;
  void page(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    Main_Page(),
    video_page(),
    events_(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: () {
        if (currentIndex == 0) return app_bar_main();
        return null;
      }(),

      body: _pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          main_page_button_bottom(),
          video_page_button_bottom(),
          events_page_button_bottom(),
          profile_page_button_bottom(),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar app_bar_main() {
    return AppBar(
      title: Center(child: Text('yazılım topluluğu')),
      backgroundColor: Color.fromARGB(255, 0, 176, 245),
    );
  }
}
