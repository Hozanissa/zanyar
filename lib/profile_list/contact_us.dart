import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

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
          ],
        ),
      ),
    );
  }
}
