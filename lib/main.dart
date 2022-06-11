
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
   // _toCommentsPage();
    posts = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Посты'),
            centerTitle: true,
          ),
          body: Center(
            child: FutureBuilder<List<Posts>>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].title),
                            subtitle: Text(snapshot.data![index].body),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage()));
                            },
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ));
  }

}