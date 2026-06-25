import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:strawnotes/change_notifiers/new_note_controller.dart';
import 'package:strawnotes/core/constants.dart';
import 'package:strawnotes/widgets/note_icon_button.dart';
import 'package:strawnotes/widgets/dialogue_card.dart';

class NoteMetaData extends StatefulWidget {
  const NoteMetaData({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NoteMetaData> createState() => _NoteMetaDataState();
}

class _NoteMetaDataState extends State<NoteMetaData> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    newNoteController = context.read<NewNoteController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newNoteController = context.read<NewNoteController>();
    return Column(
      children: [
        if (widget.isNewNote != true) ...[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Last Modified",
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "29 December 2003, 7:45 PM",
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tags",
              style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
            ),
            const SizedBox(width: 8),
            NoteIconButton(
              icon: FontAwesomeIcons.circlePlus,
              iconSize: 26,
              onPressed: () async {
                final tag = await showDialog<String>(
                  context: context,
                  builder: (context) => const DialogueCard(),
                );
                if (tag != null) {
                  newNoteController.tags = [...newNoteController.tags, tag];
                }
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Selector<NewNoteController, List<String>>(
                selector: (context, controller) => controller.tags,
                builder: (context, tags, child) {
                  if (tags.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SingleChildScrollView(
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
                              margin: const EdgeInsets.only(right: 4),
                              child: Text(
                                tag,
                                style: TextStyle(fontSize: 12, color: gray700),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
