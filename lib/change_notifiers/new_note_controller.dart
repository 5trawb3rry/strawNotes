import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:strawnotes/change_notifiers/notes_provider.dart';
import 'package:strawnotes/models/note.dart';

class NewNoteController extends ChangeNotifier {
  bool _readOnly = false;

  bool get readOnly => _readOnly;

  bool get canSaveNote {
    final String newTitle = title.isEmpty ? "Untitled" : title;
    final String newContent = content.toPlainText().trim().isEmpty
        ? ""
        : content.toPlainText().trim();
    return newTitle != title || newContent != content.toPlainText().trim();
  }

  set readOnly(bool value) {
    if (_readOnly == value) return;
    _readOnly = value;
    notifyListeners();
  }

  String _title = "";
  String get title => _title.trim();

  set title(String value) {
    if (_title == value) return;
    _title = value;
    notifyListeners();
  }

  Document _content = Document();
  Document get content => _content;

  set content(Document value) {
    if (_content == value) return;
    _content = value;
    notifyListeners();
  }

  List<String> _tags = [];
  List<String> get tags => _tags;

  set tags(List<String> value) {
    if (_tags == value) return;
    _tags = value;
    notifyListeners();
  }

  void saveNote(BuildContext context) {
    final String newTitle = title.isEmpty ? "Untitled" : title;
    final String newContent = content.toPlainText().trim().isEmpty
        ? ""
        : content.toPlainText().trim();
    final String contentJson = jsonEncode(content.toDelta().toJson());
    final int now = DateTime.now().millisecondsSinceEpoch;
    final Note note = Note(
      title: newTitle,
      content: newContent,
      contentJson: contentJson,
      dateCreated: now,
      dateUpdated: now,
      tags: tags,
    );

    context.read<NotesProvider>().addNote(note);
  }
}
