import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminReviewsScreen extends StatelessWidget {
  const AdminReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Review moderation')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collectionGroup('reviews').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Could not load reviews: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final reviews = snapshot.data!.docs;
        if (reviews.isEmpty) return const Center(child: Text('No reviews yet.'));
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: reviews.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final review = reviews[index];
            final data = review.data();
            final siteId = review.reference.parent.parent?.id ?? '';
            return Card(
              child: ListTile(
                title: Text('${data['author'] ?? 'User'} · ${data['rating'] ?? 0}/5'),
                subtitle: Text('${data['comment'] ?? ''}\nSite: $siteId'),
                isThreeLine: true,
                trailing: IconButton(
                  tooltip: 'Delete review',
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () async {
                    try {
                      await review.reference.delete();
                    } on FirebaseException catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.message ?? error.code)),
                      );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
