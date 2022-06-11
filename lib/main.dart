
import 'package:flutter/material.dart';
import 'package:flutter_test_project/PostsApiCall.dart';
import 'package:flutter_test_project/Comments.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  late Future<List<Posts>> posts;

  @override
  void initState() {
    super.initState();
    posts = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    var  postId;
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Посты'),
            centerTitle: true,
          ),
          body: Center(
            child: FutureBuilder<List<Posts>>(
                future: posts,
                builder: (context, posts) {
                  if (posts.hasData) {
                    return ListView.builder(
                        itemCount: posts.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(posts.data![index].title),
                            subtitle: Text(posts.data![index].body),
                            onTap: () {
                              postId = index;
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => CommentsPage(id: postId)));
                            },
                          );
                        });
                  } else if (posts.hasError) {
                    return Text(posts.error.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ));
  }

}