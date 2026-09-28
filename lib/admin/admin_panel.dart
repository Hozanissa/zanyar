import 'package:flutter/material.dart';
import 'package:zanyar_app/bnb.dart';

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
            title: Text("User Management"),
            subtitle: Text(
              "Used to view user accounts, suspend/ban user who violate rules, reset account or handle account-related support.",
            ),
            leading: CircleAvatar(
              backgroundColor: Color(0xFF1F4E4C).withOpacity(0.10),
              child: Icon(Icons.person, color: Color(0xFF1F4E4C)),
            ),

            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text("Content Management"),
            subtitle: Text(
              "Used to manage sites, archive, and approve/reject trip listings",
            ),
            leading: CircleAvatar(
              backgroundColor: Color(0xFF1F4E4C).withOpacity(0.10),
              child: Icon(Icons.fact_check, color: Color(0xFF1F4E4C)),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            title: Text("Travel Comapnies Management"),
            subtitle: Text(
              "Used to approve new travel companies, remove companies with bad reating/reviews, and manage company profile with their trips.",
            ),
            leading: CircleAvatar(
              backgroundColor: Color(0xFF1F4E4C).withOpacity(0.10),
              child: Icon(Icons.business, color: Color(0xFF1F4E4C)),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),

          ListTile(
            title: Text("Moderation"),
            subtitle: Text(
              "Review and moderate reviews/ratings, handle reported content and reported users",
            ),
            leading: CircleAvatar(
              backgroundColor: Color(0xFF1F4E4C).withOpacity(0.10),
              child: Icon(Icons.gavel_outlined, color: Color(0xFF1F4E4C)),
            ),
            //leading: Icon(Icons.gavel, color: Color(0xFF1F4E4C)),
            trailing: Icon(Icons.chevron_right),
            //onTap:
          ),
          Divider(),
          ListTile(
            title: Text("Analytics"),
            subtitle: Text(
              "View Number of users, trip request, and most-viewed sites",
            ),

            leading: CircleAvatar(
              backgroundColor: Color(0xFF1F4E4C).withOpacity(0.10),
              child: Icon(Icons.analytics, color: Color(0xFF1F4E4C)),
            ),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
