import 'package:flutter/material.dart';

/// Unsplash sample imagery with a graceful gradient fallback (works offline).
String unsplash(String id, {int w = 600}) => 'https://images.unsplash.com/photo-$id?auto=format&fit=crop&w=$w&q=70';

class NetImage extends StatelessWidget {
  const NetImage(this.url, {super.key, this.radius = 0, this.height, this.width, this.fit = BoxFit.cover});
  final String url;
  final double radius;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    Widget fallback() => Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [c.primary.withValues(alpha: .25), c.tertiary.withValues(alpha: .25)])),
        );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (_, __, ___) => SizedBox(height: height, width: width, child: fallback()),
        loadingBuilder: (_, child, p) => p == null ? child : SizedBox(height: height, width: width, child: fallback()),
      ),
    );
  }
}
