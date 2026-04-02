import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem({required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(note.title), subtitle: Text(note.content));
  }
}
