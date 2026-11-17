import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: ShaderMask(
          shaderCallback: (r) => brandGradient.createShader(r),
          child: const Text('circle', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1)),
        ),
        actions: [
          IconButton(onPressed: () => Contact.show(context, appName, 'Notifications & Activity'), icon: const Badge(smallSize: 8, child: Icon(Icons.favorite_border))),
        ],
      ),
      SliverToBoxAdapter(child: _Stories()),
      const SliverToBoxAdapter(child: Divider(height: 1)),
      SliverList.builder(itemCount: posts.length, itemBuilder: (_, i) => PostCard(posts[i])),
    ]);
  }
}

class _Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        itemCount: users.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) {
          if (i == 0) {
            return GestureDetector(
              onTap: () => Contact.show(context, appName, 'Stories with Filters & Music'),
              child: Column(children: [
                Stack(children: [
                  CircleAvatar(radius: 33, child: ClipOval(child: NetImage(unsplash('1544005313-94ddf0286df2', w: 200), width: 66, height: 66))),
                  Positioned(right: 0, bottom: 0, child: Container(decoration: BoxDecoration(color: brand, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: const Icon(Icons.add, size: 18, color: Colors.white))),
                ]),
                const SizedBox(height: 6),
                const Text('Your story', style: TextStyle(fontSize: 12)),
              ]),
            );
          }
          final u = users[i - 1];
          return GestureDetector(
            onTap: () => Contact.show(context, appName, 'Story Viewer & Replies'),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: brandGradient),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: ClipOval(child: NetImage(u.avatar, width: 60, height: 60)),
                ),
              ),
              const SizedBox(height: 6),
              Text(u.handle.split('.').first, style: const TextStyle(fontSize: 12)),
            ]),
          );
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  const PostCard(this.post, {super.key});
  final Post post;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  late final AnimationController heart = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

  @override
  void dispose() {
    heart.dispose();
    super.dispose();
  }

  void toggleLike({bool fromDoubleTap = false}) {
    final p = widget.post;
    setState(() {
      if (fromDoubleTap && p.liked) return;
      p.liked = !p.liked;
      p.likes += p.liked ? 1 : -1;
    });
    if (p.liked) heart.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: CircleAvatar(child: ClipOval(child: NetImage(p.user.avatar, width: 40, height: 40))),
          title: Row(children: [Text(p.user.handle, style: const TextStyle(fontWeight: FontWeight.w700)), if (p.user.verified) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.verified, size: 16, color: Color(0xFF0EA5E9)))]),
          subtitle: p.location != null ? Text(p.location!, style: const TextStyle(fontSize: 12)) : null,
          trailing: IconButton(onPressed: () => Contact.show(context, appName, 'Report, Mute & Content Moderation'), icon: const Icon(Icons.more_horiz)),
        ),
        GestureDetector(
          onDoubleTap: () => toggleLike(fromDoubleTap: true),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(fit: StackFit.expand, children: [
              NetImage(p.image),
              Center(
                child: AnimatedBuilder(
                  animation: heart,
                  builder: (_, __) {
                    final t = heart.value;
                    final scale = t < .3 ? t / .3 * 1.2 : t < .5 ? 1.2 - (t - .3) : 1.0;
                    final opacity = t == 0 ? 0.0 : (t < .6 ? 1.0 : (1 - t) / .4);
                    return Opacity(opacity: opacity.clamp(0.0, 1.0), child: Transform.scale(scale: scale, child: const Icon(Icons.favorite, color: Colors.white, size: 110, shadows: [Shadow(blurRadius: 30)])));
                  },
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(children: [
            IconButton(onPressed: toggleLike, icon: Icon(p.liked ? Icons.favorite : Icons.favorite_border, color: p.liked ? const Color(0xFFE11D48) : Colors.black87, size: 28)),
            IconButton(onPressed: () => Contact.show(context, appName, 'Comments & Replies'), icon: const Icon(Icons.mode_comment_outlined, size: 26)),
            IconButton(onPressed: () => Contact.show(context, appName, 'Share & Direct Messages'), icon: const Icon(Icons.send_outlined, size: 26)),
            const Spacer(),
            IconButton(onPressed: () => setState(() => p.saved = !p.saved), icon: Icon(p.saved ? Icons.bookmark : Icons.bookmark_border, size: 28)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${p.likes.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',')} likes', style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text.rich(TextSpan(children: [TextSpan(text: '${p.user.handle} ', style: const TextStyle(fontWeight: FontWeight.w700)), TextSpan(text: p.caption)])),
            const SizedBox(height: 4),
            Text('View all ${p.comments} comments', style: const TextStyle(color: Colors.black45)),
            Text(p.time, style: const TextStyle(color: Colors.black38, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }
}
