import 'dart:convert';

class Note {
  String title;
  String content;

  Note({required this.title, required this.content});

  // convert object → map
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }

  // map → object
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(title: map['title'], content: map['content']);
  }

  // list → json string
  static String encode(List<Note> notes) =>
      jsonEncode(notes.map((n) => n.toMap()).toList());

  // json string → list
  static List<Note> decode(String notes) => (jsonDecode(notes) as List<dynamic>)
      .map((item) => Note.fromMap(item))
      .toList();
}
