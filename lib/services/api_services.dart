import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/post.dart';

class ApiServices {
  final dio = Dio();

  Future<List<Post>> getPost() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    List<Post> posts = [];
    final List data = response.data;
    for (var element in data) {
      posts.add(Post.fromJson(element));
    }
    return posts;
  }
}
