import 'package:flutter/material.dart';
import 'package:zanyar_app/bmb.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4E4C),
        foregroundColor: Colors.grey[300],
        title: Text("Admin Control Panel"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Content Management"),
            subtitle: Text(
              "Used to manage sites, archive, and approve/reject trip listings",
            ),
            leading: Icon(Icons.fact_check),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text("Travel Comapnies Management"),
            subtitle: Text(
              "Used to approve new travel companies, remove companies with bad reating/reviews, and manage company profile with their trips.",
            ),
            leading: Icon(Icons.business),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text("User Management"),
            subtitle: Text(
              "Used to view user accounts, suspend/ban user who violate rules, reset account or handle account-related support.",
            ),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text("Moderation"),
            subtitle: Text(
              "Review and moderate reviews/ratings, handle reported content and reported users",
            ),
            leading: Icon(Icons.gavel),
            trailing: Icon(Icons.chevron_right),
            //onTap:
          ),
          Divider(),
          ListTile(
            title: Text("Analytics"),
            subtitle: Text(
              "View Number of users, trip request, and most-viewed sites",
            ),
            leading: Icon(Icons.analytics),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
      bottomNavigationBar: const BMB(),
    );
  }
}
