import 'dart:convert';

import 'package:http/http.dart' as http;


class Posts {
   int postId;
   int id;
   String title;
   String body;

  Posts({required this.postId, required this.id,
    required this.title, required this.body});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        postId: json["postId"],
        id: json["id"],
        title: json["title"],
        body: json["body"]
    );
  }
}

Future<List<Posts>> getPosts() async{
  final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/"),
  );
  if(response.statusCode == 200) {
    var jsonResponse =json.decode(response.body);
    List<Posts> posts = [];
    for(var p in jsonResponse) {
      Posts post = Posts(postId: p['postId'], id: p['id'], title: p['title'],
      body: p['body']);
      posts.add(post);
    }
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}