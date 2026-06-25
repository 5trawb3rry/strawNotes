import 'package:flutter/material.dart';
import 'package:strawnotes/models/note.dart';
import 'package:strawnotes/widgets/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const Center(child: Text('No notes found'));
    }
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true, note: notes[index]);
      },
    );
  }
}
