
import 'package:flutter/material.dart';
import 'package:flutter_test_project/CommentApiCall.dart';


class CommentsPage extends StatefulWidget {
  final int id;
  const CommentsPage({super.key, required this.id});

  @override
  State<CommentsPage> createState() => _Comments();
}
class _Comments extends State<CommentsPage>{
  late Future<List<Comments>> comments;
  @override
  void initState() {
    comments = getComments(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Комментарии'),
            centerTitle: true,
          ),
          body: Center(
            child: FutureBuilder<List<Comments>>(
                future: comments,
                builder: (context, comments) {
                  if (comments.hasData) {
                    return ListView.builder(
                        itemCount: comments.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.face),
                            title: Text(comments.data![index].name,
                              style: TextStyle(fontSize: 22),),
                            subtitle: Text(comments.data![index].body),
                          );
                        });
                  } else if (comments.hasError) {
                    return Text(comments.error.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ));
  }
}