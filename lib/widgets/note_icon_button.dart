import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:strawnotes/core/constants.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 18,
    super.key,
  });

  final FaIconData icon;
  final double? iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      iconSize: iconSize,
      color: gray700,
    );
  }
}
