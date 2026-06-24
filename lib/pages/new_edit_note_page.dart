import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:strawnotes/core/constants.dart';
import 'package:strawnotes/widgets/note_icon_button.dart';
import 'package:strawnotes/widgets/note_icon_button_outlined.dart';
import 'package:strawnotes/widgets/note_tool_bar.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({this.isNewNote, super.key});

  final bool? isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final QuillController quillController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    quillController = QuillController.basic();
    focusNode = FocusNode();
    if (widget.isNewNote == true) {
      focusNode.requestFocus();
      quillController.readOnly = false;
    } else {
      quillController.readOnly = true;
    }
  }

  @override
  void dispose() {
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(widget.isNewNote == true ? "New Note" : "Edit Note"),
        actions: [
          NoteIconButtonOutlined(
            icon: quillController.readOnly
                ? FontAwesomeIcons.pen
                : FontAwesomeIcons.bookOpen,
            onPressed: () {
              setState(() {
                quillController.readOnly = !quillController.readOnly;
              });
              if (quillController.readOnly) {
                FocusScope.of(context).unfocus();
              } else {
                focusNode.requestFocus();
              }
            },
          ),
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.check,
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

              decoration: InputDecoration(
                hintText: "Title Here",
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
            ),
            if (widget.isNewNote != true) ...[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Last Modified",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "29 December 2003, 7:45 PM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Tags",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray900,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "29 December 2003, 7:45 PM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray900,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                NoteIconButton(
                  icon: FontAwesomeIcons.circlePlus,
                  onPressed: () {},
                ),
              ],
            ),

            Row(children: [Text("no tags")]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: QuillEditor.basic(
                      controller: quillController,
                      config: QuillEditorConfig(
                        placeholder: 'Note here...',
                        expands: true,
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                  if (!quillController.readOnly)
                    NoteToolBar(quillController: quillController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
