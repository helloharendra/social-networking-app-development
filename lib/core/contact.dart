import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Naya Prayog Technologies — get the complete, production-ready app.
class Contact {
  static const website = 'https://nayaprayog.com/';
  static const email = 'support@nayaprayog.com';
  static const phone = '+91 7991327022';
  static const whatsapp = '917991327022';

  static const includes = [
    'Complete Flutter source code',
    'Backend APIs & admin panel',
    'Auth, payments & notifications',
    'Play Store / App Store release',
  ];

  /// Shows the "available in full version" sheet. Every locked feature calls this.
  static Future<void> show(BuildContext context, String appName, [String? feature]) {
    final scheme = Theme.of(context).colorScheme;
    final msg = Uri.encodeComponent('Hi Naya Prayog, I saw the $appName demo on GitHub and I am interested in the complete project.');
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(4)))),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: scheme.primary.withValues(alpha: .1), borderRadius: BorderRadius.circular(20)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.lock_rounded, size: 14, color: scheme.primary),
                  const SizedBox(width: 6),
                  Text('Available in full version', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: scheme.primary)),
                ]),
              ),
              const SizedBox(height: 14),
              Text(feature ?? appName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('This repository is a UI preview of $appName. The complete app with backend, admin panel and store release is available from Naya Prayog Technologies.',
                  style: const TextStyle(color: Colors.black54, height: 1.45)),
              const SizedBox(height: 16),
              ...includes.map((i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(children: [Icon(Icons.check_circle_rounded, size: 18, color: scheme.primary), const SizedBox(width: 10), Text(i)]),
                  )),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF22C55E), padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () => launchUrl(Uri.parse('https://wa.me/$whatsapp?text=$msg'), mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.chat_rounded),
                    label: const Text('WhatsApp'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: () => launchUrl(Uri.parse('mailto:$email?subject=${Uri.encodeComponent('$appName – complete project')}')),
                    icon: const Icon(Icons.mail_rounded),
                    label: const Text('Email us'),
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => launchUrl(Uri.parse(website), mode: LaunchMode.externalApplication),
                  child: const Text('nayaprayog.com  ·  $phone'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
