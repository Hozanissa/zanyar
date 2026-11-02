import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zanyar/main_screens/archive.dart';

class AdminArchiveScreen extends StatelessWidget {
  const AdminArchiveScreen({super.key});

  CollectionReference<Map<String, dynamic>> get _collection =>
      FirebaseFirestore.instance.collection('archiveItems');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Archive content')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _collection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Could not load archive content: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = [...snapshot.data!.docs]
            ..sort((a, b) {
              final category = (a.data()['category'] as String? ?? '')
                  .compareTo(b.data()['category'] as String? ?? '');
              if (category != 0) return category;
              return (a.data()['title'] as String? ?? '').compareTo(
                b.data()['title'] as String? ?? '',
              );
            });
          if (documents.isEmpty) {
            return const Center(
              child: Text('No archive stories yet. Add one to begin.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: documents.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final document = documents[index];
              final data = document.data();
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.auto_stories_outlined),
                  title: Text(data['title'] as String? ?? '(Untitled story)'),
                  subtitle: Text(
                    '${data['category'] ?? ''} · ${data['period'] ?? ''}\n${data['story'] ?? ''}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: true,
                  onTap: () => _edit(context, document: document),
                  trailing: IconButton(
                    tooltip: 'Delete story',
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _delete(context, document.reference),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(context),
        icon: const Icon(Icons.add),
        label: const Text('Add story'),
      ),
    );
  }

  Future<void> _edit(
    BuildContext context, {
    QueryDocumentSnapshot<Map<String, dynamic>>? document,
  }) async {
    final data = document?.data() ?? <String, dynamic>{};
    const fields = <String, String>{
      'title': 'Title (English)',
      'kurdishTitle': 'Kurdish title (optional)',
      'subtitle': 'Short description',
      'kurdishSubtitle': 'Kurdish short description (optional)',
      'badge': 'Badge (Epic, Poet, Chronicle...)',
      'kurdishBadge': 'Kurdish badge (optional)',
      'period': 'Period / date',
      'kurdishPeriod': 'Kurdish period / date (optional)',
      'story': 'Story (English)',
      'significance': 'Cultural significance (English)',
      'kurdishStory': 'Kurdish story (optional)',
      'kurdishSignificance': 'Kurdish significance (optional)',
    };
    final controllers = <String, TextEditingController>{
      for (final key in fields.keys)
        key: TextEditingController(text: data[key] as String? ?? ''),
    };
    var category = data['category'] as String? ?? 'Folklore';
    final formKey = GlobalKey<FormState>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('${document == null ? 'Add' : 'Edit'} archive story'),
          content: SizedBox(
            width: 520,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.68,
              ),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: const ['Folklore', 'Poets', 'Scholars']
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null)
                          setDialogState(() => category = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    ...fields.entries.map((entry) {
                      final key = entry.key;
                      final isLongText =
                          key.toLowerCase().contains('story') ||
                          key.toLowerCase().contains('significance');
                      final optional = key.startsWith('kurdish');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TextFormField(
                          controller: controllers[key],
                          minLines: isLongText ? 4 : 1,
                          maxLines: isLongText ? 8 : 1,
                          keyboardType: isLongText
                              ? TextInputType.multiline
                              : TextInputType.text,
                          textCapitalization: isLongText
                              ? TextCapitalization.sentences
                              : TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: entry.value,
                            alignLabelWithHint: isLongText,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              !optional &&
                                  (value == null || value.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final item = ArchiveItem(
                  id: document?.id ?? '',
                  category: category,
                  title: controllers['title']!.text.trim(),
                  kurdishTitle: controllers['kurdishTitle']!.text.trim(),
                  subtitle: controllers['subtitle']!.text.trim(),
                  kurdishSubtitle: controllers['kurdishSubtitle']!.text.trim(),
                  badge: controllers['badge']!.text.trim(),
                  kurdishBadge: controllers['kurdishBadge']!.text.trim(),
                  period: controllers['period']!.text.trim(),
                  kurdishPeriod: controllers['kurdishPeriod']!.text.trim(),
                  story: controllers['story']!.text.trim(),
                  significance: controllers['significance']!.text.trim(),
                  kurdishStory: controllers['kurdishStory']!.text.trim(),
                  kurdishSignificance: controllers['kurdishSignificance']!.text
                      .trim(),
                );
                try {
                  if (document == null) {
                    await _collection.add(item.toMap());
                  } else {
                    await document.reference.set(item.toMap());
                  }
                  if (dialogContext.mounted) Get.back(result: true);
                } on FirebaseException catch (error) {
                  Get.snackbar('Save failed', error.message ?? error.code);
                }
              },
              child: const Text('Save story'),
            ),
          ],
        ),
      ),
    );
    for (final controller in controllers.values) {
      controller.dispose();
    }
    if (saved == true) Get.snackbar('Saved', 'Archive story saved.');
  }

  Future<void> _delete(
    BuildContext context,
    DocumentReference<Map<String, dynamic>> reference,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this story?'),
        content: const Text(
          'This removes the story from the archive for all users.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) return;
    try {
      await reference.delete();
      Get.snackbar('Deleted', 'The story was removed from the archive.');
    } on FirebaseException catch (error) {
      Get.snackbar('Delete failed', error.message ?? error.code);
    }
  }
}
