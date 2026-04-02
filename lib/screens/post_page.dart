import 'package:flutter/material.dart';
import 'package:note_app/models/post.dart';
import 'package:note_app/services/api_services.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await ApiServices().getPost();
    if (response != null) {
      posts = response;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: Center(child: Text('Posts page')),
    );
  }
}
