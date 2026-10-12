import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  static const String phone = '+9647511292504';
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
      appBar: AppBar(
        title: Text(
          'Contact Us'.tr,
          style: GoogleFonts.lora(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.teal,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We'd Love to hear from you!!!",
              style: GoogleFonts.lora(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.teal,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                //Facebook url launcher.

                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: IconButton(
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
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Facebook'),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(width: 20),
                SizedBox(height: 20),

                //email
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: IconButton(
                        onPressed: () async {
                          final Uri urlEmail = Uri(
                            scheme: 'mailto',
                            path: 'hozanissa98@gmail.com',
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
                        icon: const Icon(
                          Icons.email,
                          color: Colors.redAccent,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Email'),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(width: 20),
                SizedBox(height: 20),
                // Phone call
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: IconButton(
                        onPressed: () =>
                            _open(context, Uri(scheme: 'tel', path: phone)),
                        icon: const Icon(
                          Icons.call,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Phone'),
                  ],
                ),
              ],
            ),

            // SMS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                SizedBox(width: 20),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: IconButton(
                        onPressed: () =>
                            _open(context, Uri(scheme: 'sms', path: phone)),
                        icon: const Icon(
                          Icons.sms,
                          color: Colors.orange,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("SMS"),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(width: 20),
                SizedBox(height: 20),

                // GitHub
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: IconButton(
                        onPressed: () => _open(context, Uri.parse(githubUrl)),
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.purple,
                          size: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text("Github"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
