import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strawnotes/change_notifiers/new_note_controller.dart';
import 'package:strawnotes/models/note.dart';
import 'package:strawnotes/pages/new_edit_note_page.dart';
import '../core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.isInGrid, required this.note});

  final bool isInGrid;
  final Note note;



  @override
  Widget build(BuildContext context) {
    final tags = note.tags ?? [];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NewNoteController(),
              child: NewOrEditNotePage(isNewNote: false),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.5),
              offset: Offset(4, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: gray900,
              ),
            ),
            SizedBox(height: 4),
            if (tags.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tags
                      .map(
                        (tag) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: gray100,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          margin: EdgeInsets.only(right: 4),
                          child: Text(
                            tag,
                            style: TextStyle(fontSize: 12, color: gray700),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            SizedBox(height: 4),
            if (isInGrid)
              Expanded(
                child: Text(
                  note.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: gray700),
                ),
              )
            else
              Text(
                note.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: gray700),
              ),
            Row(
              children: [
                Text(
                  DateFormat('dd MMM, yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(note.dateCreated),
                  ),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                FaIcon(FontAwesomeIcons.trash, color: gray500, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
