import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.isInGrid});

  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'This is a title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: gray900,
            ),
          ),
          SizedBox(height: 4),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
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
                    'First chip',
                    style: TextStyle(fontSize: 12, color: gray700),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          if (isInGrid)
            Expanded(
              child: Text(
                'Some Content',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: gray700),
              ),
            )
          else
            Text(
              'Some Content',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: gray700),
            ),
          Row(
            children: [
              Text(
                '29 Dec, 2003',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              FaIcon(FontAwesomeIcons.trash, color: gray500, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
