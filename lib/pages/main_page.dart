import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:strawnotes/core/constants.dart';
import 'package:strawnotes/pages/new_edit_note_page.dart';
import 'package:strawnotes/widgets/note_fab.dart';
import 'package:strawnotes/widgets/note_grid.dart';
import 'package:strawnotes/widgets/note_icon_button.dart';
import 'package:strawnotes/widgets/note_icon_button_outlined.dart'
    show NoteIconButtonOutlined;
import 'package:strawnotes/widgets/note_list.dart';
import 'package:strawnotes/widgets/search_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> dropdownOptions = ['Last Modified', 'Created Date'];
  String selectedSortOption = 'Last Modified';

  bool isDescending = true;
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Straw Notes"),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOrEditNotePage(isNewNote: true),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchField(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  NoteIconButton(
                    icon: isDescending
                        ? FontAwesomeIcons.arrowDown
                        : FontAwesomeIcons.arrowUp,
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                  ),
                  SizedBox(width: 16),
                  DropdownButton<String>(
                    value: selectedSortOption,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownWideShort,
                        size: 18,
                        color: gray700,
                      ),
                    ),
                    underline: const SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(16),
                    isDense: true,
                    items: dropdownOptions.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(e),
                            if (e == selectedSortOption) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.check),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (context) => dropdownOptions.map((e) {
                      return Text(e);
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSortOption = value;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  NoteIconButton(
                    icon: isGrid
                        ? FontAwesomeIcons.tableCellsLarge
                        : FontAwesomeIcons.bars,
                    iconSize: 10,
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: isGrid ? NotesGrid() : NotesList()),
          ],
        ),
      ),
    );
  }
}
