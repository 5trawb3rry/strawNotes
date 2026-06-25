import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:strawnotes/change_notifiers/new_note_controller.dart';
import 'package:strawnotes/core/constants.dart';
import 'package:strawnotes/widgets/note_icon_button_outlined.dart';
import 'package:strawnotes/widgets/note_meta_data.dart';
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
  late final NewNoteController newNoteController;

  bool _providerInitialized = false;

  @override
  void initState() {
    super.initState();
    quillController = QuillController.basic()
      ..addListener(() {
        if (!newNoteController.readOnly) {
          newNoteController.content = quillController.document;
        }
      });

    focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_providerInitialized) {
      _providerInitialized = true;
      newNoteController = context.read<NewNoteController>();
      if (widget.isNewNote == true) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: white,
            shadowColor: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
            title: const Text(
              "Save Note",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: const Text("Do you want to save this note?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Dismiss dialog
                  Navigator.pop(context); // Exit page
                },
                child: const Text("No", style: TextStyle(color: gray700)),
              ),
              ElevatedButton(
                onPressed: () {
                  newNoteController.saveNote(context);
                  Navigator.pop(context); // Dismiss dialog
                  Navigator.pop(context); // Exit page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Text("Yes"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
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
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.readOnly,
              builder: (context, readOnly, child) => NoteIconButtonOutlined(
                icon: readOnly
                    ? FontAwesomeIcons.pen
                    : FontAwesomeIcons.bookOpen,
                onPressed: () {
                  newNoteController.readOnly = !readOnly;

                  if (newNoteController.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
              ),
            ),
            Selector<NewNoteController, bool>(
              selector: (context, newNoteController) =>
                  newNoteController.canSaveNote,
              builder: (context, canSaveNote, _) => NoteIconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: () {
                  newNoteController.saveNote(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewNoteController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

                  decoration: InputDecoration(
                    hintText: "Title Here",
                    hintStyle: TextStyle(color: gray300),
                    border: InputBorder.none,
                  ),
                  canRequestFocus: !readOnly,
                  onChanged: (newValue) {
                    if (readOnly) return;
                    newNoteController.title = newValue;
                  },
                ),
              ),
              NoteMetaData(isNewNote: widget.isNewNote ?? false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: gray500, thickness: 2),
              ),
              Expanded(
                child: Selector<NewNoteController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (context, readOnly, child) => Column(
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
                      if (!readOnly)
                        NoteToolBar(quillController: quillController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
