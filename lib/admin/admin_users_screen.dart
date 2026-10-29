import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('User management')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Could not load users: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.docs.isEmpty) return const Center(child: Text('No user profiles yet.'));
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final data = doc.data();
            final name = '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}'.trim();
            final suspended = data['status'] == 'suspended';
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(name.isEmpty ? 'U' : name[0].toUpperCase())),
                title: Text(name.isEmpty ? (data['email'] as String? ?? 'User') : name),
                subtitle: Text('${data['email'] ?? ''}\n${data['phone'] ?? ''}'),
                isThreeLine: true,
                trailing: TextButton(
                  onPressed: () async {
                    try {
                      await doc.reference.update({'status': suspended ? 'active' : 'suspended'});
                    } on FirebaseException catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.message ?? error.code)),
                      );
                    }
                  },
                  child: Text(suspended ? 'Reactivate' : 'Suspend'),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
