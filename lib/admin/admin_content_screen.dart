import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminContentScreen extends StatelessWidget {
  final bool manageSites;
  const AdminContentScreen({super.key, required this.manageSites});

  String get _collection => manageSites ? 'sites' : 'companies';
  String get _title => manageSites ? 'Historical sites' : 'Travel companies';

  @override
  Widget build(BuildContext context) {
    final collection = FirebaseFirestore.instance.collection(_collection);
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(context, collection),
        icon: const Icon(Icons.add),
        label: Text('Add ${manageSites ? 'site' : 'company'}'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Could not load $_title: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(child: Text('No $_title yet. Use Add to create the first one.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
            itemCount: docs.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data();
              return Card(
                child: ListTile(
                  leading: Icon(manageSites ? Icons.account_balance : Icons.business),
                  title: Text(data['name'] as String? ?? '(No name)'),
                  subtitle: Text(
                    manageSites
                        ? '${data['city'] ?? ''} · ${data['category'] ?? ''}'
                        : '${data['tripDate'] ?? ''} · ${data['price'] ?? 0} IQD',
                  ),
                  onTap: () => _edit(context, collection, document: doc),
                  trailing: IconButton(
                    tooltip: 'Delete',
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _delete(context, doc.reference),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    CollectionReference<Map<String, dynamic>> collection, {
    QueryDocumentSnapshot<Map<String, dynamic>>? document,
  }) async {
    final data = document?.data() ?? <String, dynamic>{};
    final fields = manageSites
        ? <String, String>{
            'name': 'Name',
            'kurdishName': 'Kurdish name (optional)',
            'city': 'City / region',
            'category': 'Category',
            'description': 'Description',
            'kurdishDescription': 'Kurdish description (optional)',
            'hours': 'Opening hours',
            'period': 'Historical period',
            'entry': 'Entry fee',
            'status': 'Status / designation',
            'lat': 'Latitude',
            'lng': 'Longitude',
            'imageUrls': 'Image URLs (one per line)',
          }
        : <String, String>{
            'name': 'Company name',
            'tripDate': 'Trip date / schedule',
            'tripType': 'Trip duration / type',
            'price': 'Price in IQD',
            'spotsAvailable': 'Available places',
          };
    final controllers = <String, TextEditingController>{};
    for (final key in fields.keys) {
      final value = data[key];
      controllers[key] = TextEditingController(
        text: key == 'imageUrls' && value is List
            ? value.join('\n')
            : value?.toString() ?? '',
      );
    }
    final formKey = GlobalKey<FormState>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${document == null ? 'Add' : 'Edit'} ${manageSites ? 'site' : 'company'}'),
        content: SizedBox(
          width: 480,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: fields.entries.map((entry) {
                  final multiline = entry.key.toLowerCase().contains('description') ||
                      entry.key == 'imageUrls';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextFormField(
                      controller: controllers[entry.key],
                      keyboardType: const {'lat', 'lng', 'price', 'spotsAvailable'}
                              .contains(entry.key)
                          ? const TextInputType.numberWithOptions(decimal: true)
                          : TextInputType.text,
                      maxLines: multiline ? 3 : 1,
                      decoration: InputDecoration(
                        labelText: entry.value,
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: multiline,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          if (entry.key == 'kurdishName' ||
                              entry.key == 'kurdishDescription' ||
                              entry.key == 'imageUrls') {
                            return null;
                          }
                          return 'Required';
                        }
                        if (const {'lat', 'lng', 'price', 'spotsAvailable'}
                            .contains(entry.key)) {
                          final number = entry.key == 'spotsAvailable'
                              ? int.tryParse(value.trim())
                              : num.tryParse(value.trim());
                          if (number == null) return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final result = <String, dynamic>{};
              for (final key in fields.keys) {
                final value = controllers[key]!.text.trim();
                if (key == 'imageUrls') {
                  result[key] = value
                      .split(RegExp(r'[\r\n]+'))
                      .map((url) => url.trim())
                      .where((url) => url.isNotEmpty)
                      .toList();
                } else if (const {'lat', 'lng', 'price'}.contains(key)) {
                  result[key] = num.parse(value).toDouble();
                } else if (key == 'spotsAvailable') {
                  result[key] = int.parse(value);
                } else {
                  result[key] = value;
                }
              }
              try {
                if (document == null) {
                  await collection.add(result);
                } else {
                  await document.reference.set(result, SetOptions(merge: true));
                }
                if (dialogContext.mounted) Navigator.pop(dialogContext, true);
              } on FirebaseException catch (error) {
                Get.snackbar('Save failed', error.message ?? error.code);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    for (final controller in controllers.values) {
      controller.dispose();
    }
    if (saved == true) Get.snackbar('Saved', '${manageSites ? 'Site' : 'Company'} saved.');
  }

  Future<void> _delete(BuildContext context, DocumentReference<Map<String, dynamic>> ref) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this item?'),
        content: const Text('This removes it from the app for all users.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Delete')),
        ],
      ),
    );
    if (shouldDelete != true) return;
    try {
      await ref.delete();
      Get.snackbar('Deleted', 'The item was removed.');
    } on FirebaseException catch (error) {
      Get.snackbar('Delete failed', error.message ?? error.code);
    }
  }
}
