class Note {
  final String title;
  final String content;
  final String contentJson;
  final int dateCreated;
  final int dateUpdated;
  final List<String>? tags;

  Note({
    required this.title,
    required this.content,
    required this.contentJson,
    required this.dateCreated,
    required this.dateUpdated,
    required this.tags,
  });
}
