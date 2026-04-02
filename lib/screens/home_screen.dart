import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/services/note_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authService = AuthService();
  final noteService = NoteService();
  String username = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final name = await authService.getUsername();
    await noteService.loadNotes();

    setState(() {
      username = name ?? "Guest";
    });
  }

  void handleLogout() async {
    await authService.logout();
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = noteService.getNotes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Xin chào $username"),
        actions: [
          IconButton(
            onPressed: handleLogout,
            icon: Icon(Icons.logout),
            color: Color(0xFF000000),
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(child: Text("Chưa có note nào"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      setState(() {
                        noteService.deleteNote(index);
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNoteScreen()),
          );

          if (result == true) {
            setState(() {}); // reload list
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
