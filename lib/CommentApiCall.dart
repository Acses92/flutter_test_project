import 'dart:convert';

import 'package:http/http.dart' as http;


class Comments {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comments({required this.postId, required this.id,
    required this.name, required this.email, required this.body});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],

    );
  }
}

Future<List<Comments>> getComments(var id) async{
  final response = await http.get(
    Uri.parse("https://jsonplaceholder.typicode.com/posts/${id}/comments"),
  );
  if(response.statusCode == 200) {
    var jsonResponse =json.decode(response.body);
    List<Comments> posts = [];
    for(var c in jsonResponse) {
      Comments post = Comments(postId: c['postId'], id: c['id'], name: c['name'],
      email: c["email"], body: c['body']);
      posts.add(post);
    }
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}