import 'package:flutter/material.dart';
import '../services/note_service.dart';
import '../models/note.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final noteService = NoteService();

  void saveNote(BuildContext context) {
    final title = titleController.text;
    final content = contentController.text;

    if (title.isEmpty || content.isEmpty) return;

    noteService.addNote(Note(title: title, content: content));

    Navigator.pop(context, true); // báo về Home reload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm Note")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Content"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => saveNote(context),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
