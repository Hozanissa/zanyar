import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  static const String phone = '+9647501234567';
  static const String githubUrl = 'https://github.com/Hozanissa';

  Future<void> _open(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the app')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact us")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Facebook url launcher.
            IconButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                  'https://www.facebook.com/profile.php?id=61581997766044',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: Icon(Icons.facebook, color: Colors.blue, size: 45),
            ),
            //email
            IconButton(
              onPressed: () async {
                final Uri urlEmail = Uri(
                  scheme: 'mailto',
                  path: 'hozanissa98@gmail.com',
                  query:
                      'subject=${Uri.encodeComponent("Training Course")}'
                      '&body=${Uri.encodeComponent("Thanks GIZ for this training course")}',
                );

                final ok = await launchUrl(urlEmail);
                if (!ok && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not open the email app'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.email, color: Colors.redAccent, size: 45),
            ),
            // Phone call
            IconButton(
              onPressed: () => _open(context, Uri(scheme: 'tel', path: phone)),
              icon: const Icon(Icons.call, color: Colors.green, size: 45),
            ),

            // SMS
            IconButton(
              onPressed: () => _open(
                context,
                Uri(
                  scheme: 'sms',
                  path: phone,
                  queryParameters: {
                    'body': 'Hello, I would like to ask about...',
                  },
                ),
              ),
              icon: const Icon(Icons.sms, color: Colors.orange, size: 45),
            ),

            // GitHub
            IconButton(
              onPressed: () => _open(context, Uri.parse(githubUrl)),
              icon: FaIcon(
                FontAwesomeIcons.github,
                color: Colors.purple,
                size: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
