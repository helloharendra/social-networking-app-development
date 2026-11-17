import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const tags = ['For you', 'Travel', 'Food', 'Fitness', 'Art', 'Tech', 'Music'];
  int tag = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
        child: TextField(
          readOnly: true,
          onTap: () => Contact.show(context, appName, 'Search People, Hashtags & Places'),
          decoration: InputDecoration(
            hintText: 'Search people, #tags, places',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        ),
      ),
      SizedBox(
        height: 48,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          itemCount: tags.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) => ChoiceChip(
            label: Text(tags[i]),
            selected: tag == i,
            showCheckmark: false,
            selectedColor: brand,
            labelStyle: TextStyle(color: tag == i ? Colors.white : Colors.black87, fontWeight: FontWeight.w600),
            onSelected: (_) => setState(() => tag = i),
          ),
        ),
      ),
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
          itemCount: explore.length,
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => Contact.show(context, appName, 'Post Viewer & Reels'),
            child: Stack(fit: StackFit.expand, children: [
              NetImage(explore[(i + tag) % explore.length]),
              if (i % 4 == 1) const Positioned(right: 6, top: 6, child: Icon(Icons.play_circle_fill, color: Colors.white, size: 20)),
            ]),
          ),
        ),
      ),
    ]);
  }
}
