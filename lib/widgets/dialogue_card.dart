import 'package:flutter/material.dart';
import '../core/constants.dart';

class DialogueCard extends StatefulWidget {
  const DialogueCard({super.key});

  @override
  State<DialogueCard> createState() => _DialogueCardState();
}

class _DialogueCardState extends State<DialogueCard> {
  late final TextEditingController tagController;

  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController();
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      shadowColor: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      title: Text(
        "Add Tag",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: tagKey,
            controller: tagController,
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Tag cannot be empty";
              }
              if (value.length > 16) {
                return "Tag cannot be longer than 16 characters";
              }
              return null;
            },
            onChanged: (newValue) {
              tagKey.currentState?.validate();
            },
            decoration: InputDecoration(
              hintText: "Add Tag (<16 characters)",
              errorMaxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (tagKey.currentState?.validate() ?? false) {
                  Navigator.pop(context, tagController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
