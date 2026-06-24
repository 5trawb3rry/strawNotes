import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:strawnotes/core/constants.dart';

class NoteToolBar extends StatelessWidget {
  const NoteToolBar({super.key, required this.quillController});

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: primary, offset: Offset(2, 2))],
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: const QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconData: Icons.rotate_left,
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconData: Icons.rotate_right,
            ),
            bold: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_bold,
              iconSize: 22,
            ),
            italic: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_italic,
              iconSize: 22,
            ),
            underLine: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_underlined,
              iconSize: 22,
            ),
            strikeThrough: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_strikethrough,
              iconSize: 22,
            ),
            color: QuillToolbarColorButtonOptions(
              iconData: Icons.format_color_text,
              iconSize: 22,
            ),
            backgroundColor: QuillToolbarColorButtonOptions(
              iconData: Icons.format_color_fill,
              iconSize: 22,
            ),
            clearFormat: QuillToolbarClearFormatButtonOptions(
              iconData: Icons.format_clear,
              iconSize: 22,
            ),
            listNumbers: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_list_numbered,
              iconSize: 22,
            ),
            listBullets: QuillToolbarToggleStyleButtonOptions(
              iconData: Icons.format_list_bulleted,
              iconSize: 22,
            ),
            search: QuillToolbarSearchButtonOptions(
              iconData: Icons.search,
              iconSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
