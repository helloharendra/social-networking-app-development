import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 120,
                decoration: const BoxDecoration(gradient: brandGradient),
                alignment: Alignment.topRight,
                child: IconButton(onPressed: () => Contact.show(context, appName, 'Settings & Privacy'), icon: const Icon(Icons.settings_outlined, color: Colors.white)),
              ),
              Transform.translate(
                offset: const Offset(16, -44),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: ClipOval(child: NetImage(unsplash('1544005313-94ddf0286df2', w: 300), width: 88, height: 88)),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -36),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Row(children: [Text('Priya Sharma', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)), SizedBox(width: 4), Icon(Icons.verified, color: Color(0xFF0EA5E9), size: 20)]),
                    const Text('@priya.creates', style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 8),
                    const Text('Designer · Storyteller · Chai enthusiast ☕\nBengaluru, India', style: TextStyle(height: 1.4)),
                    const SizedBox(height: 14),
                    Row(children: [
                      for (final (n, l) in [('248', 'Posts'), ('18.4K', 'Followers'), ('612', 'Following')])
                        Expanded(child: Column(children: [Text(n, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)), Text(l, style: const TextStyle(color: Colors.black54, fontSize: 12))])),
                    ]),
                    const SizedBox(height: 14),
                    Row(children: [
                      Expanded(child: FilledButton(onPressed: () => Contact.show(context, appName, 'Edit Profile'), child: const Text('Edit profile'))),
                      const SizedBox(width: 10),
                      Expanded(child: OutlinedButton(onPressed: () => Contact.show(context, appName, 'Creator Dashboard & Analytics'), child: const Text('Insights'))),
                    ]),
                  ]),
                ),
              ),
            ]),
          ),
          const SliverToBoxAdapter(child: TabBar(tabs: [Tab(icon: Icon(Icons.grid_on_rounded)), Tab(icon: Icon(Icons.bookmark_border))])),
        ],
        body: TabBarView(children: [
          _grid(explore),
          _grid(explore.reversed.toList()),
        ]),
      ),
    );
  }

  Widget _grid(List<String> imgs) => GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
        itemCount: imgs.length,
        itemBuilder: (_, i) => NetImage(imgs[i]),
      );
}
