// Circle – Social networking app UI demo by Naya Prayog Technologies (https://nayaprayog.com)
// Run: flutter pub get && flutter run   (Android, iOS or Chrome)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/contact.dart';
import 'screens/explore.dart';
import 'screens/feed.dart';
import 'screens/profile.dart';

const appName = 'Circle';
const brand = Color(0xFF7C3AED);
const brandGradient = LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFFDB2777), Color(0xFFF59E0B)]);

void main() => runApp(const CircleApp());

class CircleApp extends StatelessWidget {
  const CircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand, tertiary: const Color(0xFFDB2777)));
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(scaffoldBackgroundColor: Colors.white, textTheme: GoogleFonts.interTextTheme(base.textTheme)),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: i, children: const [FeedScreen(), ExploreScreen(), ProfileScreen()])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 68,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _nav(Icons.home_outlined, Icons.home_rounded, 0),
          _nav(Icons.explore_outlined, Icons.explore, 1),
          GestureDetector(
            onTap: () => Contact.show(context, appName, 'Create Post, Reels & Stories'),
            child: Container(width: 52, height: 40, decoration: BoxDecoration(gradient: brandGradient, borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.add_rounded, color: Colors.white, size: 28)),
          ),
          IconButton(onPressed: () => Contact.show(context, appName, 'Real-time Messaging'), icon: const Badge(label: Text('4'), child: Icon(Icons.send_outlined))),
          _nav(Icons.person_outline, Icons.person, 2),
        ]),
      ),
    );
  }

  Widget _nav(IconData icon, IconData active, int idx) => IconButton(
        onPressed: () => setState(() => i = idx),
        icon: Icon(i == idx ? active : icon, color: i == idx ? brand : Colors.black87, size: 26),
      );
}
