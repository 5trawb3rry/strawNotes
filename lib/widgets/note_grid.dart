import 'package:flutter/material.dart';
import 'package:strawnotes/widgets/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, int index) {
        return const NoteCard(isInGrid: true);
      },
    );
  }
}
