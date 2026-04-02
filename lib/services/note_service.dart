import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteService {
  static final NoteService _instance = NoteService._internal();

  factory NoteService() => _instance;

  NoteService._internal();

  static const String keyNotes = "notes";

  List<Note> _notes = [];

  List<Note> getNotes() => _notes;

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(keyNotes);

    if (data != null) {
      _notes = Note.decode(data);
    }
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyNotes, Note.encode(_notes));
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    await saveNotes();
  }

  Future<void> deleteNote(int index) async {
    _notes.removeAt(index);
    await saveNotes();
  }
}
