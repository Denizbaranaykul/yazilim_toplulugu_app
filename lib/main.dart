import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yazilim_toplulugu_app/pages/forum_page/forum_page.dart';
import 'package:yazilim_toplulugu_app/pages/main_page/bottom_navigationbar.dart';
import 'package:yazilim_toplulugu_app/pages/main_page/main_page_body.dart';
import 'package:yazilim_toplulugu_app/pages/events_page/events_page.dart';
import 'package:yazilim_toplulugu_app/pages/main_page/main_page.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/profile_page.dart';
import 'package:yazilim_toplulugu_app/pages/videos_page/videos_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yazilim_toplulugu_app/service/Auth_gate.dart';
import 'package:yazilim_toplulugu_app/service/notification_question.dart';
import 'package:yazilim_toplulugu_app/variable/globals.dart';
import 'service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();

  await Permission.notification.request();

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
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        opacity_main_logo = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "My_font"),
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

  // sayfalar listesi
  final List<Widget> _pages = [
    Main_Page(),
    video_page(),
    events_(),
    ForumPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: () {
        if (currentIndex == 0) {
          return app_bar_main(); //ana sayfa currentIndexte 0 0 sa appbarı maini çağrıyor değilse diğerlerinin appbarları zaten kendi pagelerinde
        }
        return null;
      }(),
      //pages listesinden indexe göre gosterme yapıyoruz
      body: _pages[currentIndex],
      //alt barda ki iconlar ile sayfa geçişini sağlıyoruz
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(249, 17, 0, 10),
        type: BottomNavigationBarType.shifting,
        items: [
          main_page_button_bottom(),
          video_page_button_bottom(),
          events_page_button_bottom(),
          forum_page_button_bottom(),
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
}
