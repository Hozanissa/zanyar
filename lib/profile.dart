import 'package:flutter/material.dart';

import 'bnb.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool theme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("ACCOUNT", style: TextStyle(color: Colors.grey[400])),
          Text(
            "Profile",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text("S")),
                    title: Text("Sarwar Karim"),
                    subtitle: Text("sarwar@example.com"),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Language"),
                    subtitle: SwitchListTile(
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
                    leading: Icon(Icons.notification_add),
                    title: Text("Notifications"),
                    subtitle: Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Favorites"),
                    subtitle: Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.trip_origin),
                    title: Text("My trip requests"),
                    subtitle: Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Sign out"),
                    subtitle: Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
