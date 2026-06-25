import 'package:flutter/material.dart';
import 'package:strawnotes/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes];

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    _notes.remove(note);
    _notes.add(note);
    notifyListeners();
  }

  void addTags(Note note, List<String> tags) {
    note.tags!.addAll(tags);
    notifyListeners();
  }

  void removeTags(Note note, List<String> tags) {
    note.tags!.removeWhere((tag) => tags.contains(tag));
    notifyListeners();
  }

  void clearTags(Note note) {
    note.tags!.clear();
    notifyListeners();
  }
}
