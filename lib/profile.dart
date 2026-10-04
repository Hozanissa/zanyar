import 'package:flutter/material.dart';

import 'bnb.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool theme = false;
  bool language = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ACCOUNT",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xFF1F4E4C)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text("S")),
                        title: Text("Hozan Issa"),
                        subtitle: Text("hozan@example.com"),
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text("Theme"),
                      trailing: Switch(
                        value: theme,
                        onChanged: (value) {
                          setState(() {
                            theme = value;
                          });
                        },
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text("Favorites"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("My trip requests"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Notifications"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "Sign out",
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Icon(Icons.chevron_right, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
