import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact us")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
            ),
            IconButton(
              onPressed: () async {
                String subject = Uri.encodeComponent("Training Course");
                String body = Uri.encodeComponent(
                  "Thanks GIZ for this training course",
                );
                final Uri urlEmail = Uri(
                  scheme: 'mailto',
                  path: 'hozanissa98@gmail.com',
                  queryParameters: {'subject': subject, 'body': body},
                );
                if (await canLaunchUrl(urlEmail)) {
                  await launchUrl(urlEmail);
                } else {
                  throw 'Could not launch $urlEmail';
                }
              },
              icon: Icon(Icons.email, color: Colors.redAccent, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}
