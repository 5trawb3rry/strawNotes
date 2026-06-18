import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:strawnotes/core/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search notes...",
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: const Center(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 16),
        ),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(minWidth: 42, minHeight: 42),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),
      ),
    );
  }
}
