
import 'package:flutter/material.dart';
import 'package:flutter_test_project/CommentApiCall.dart';


class CommentsPage extends StatefulWidget {

  const CommentsPage({super.key, required this.id});
  final int id;

  @override
  State<CommentsPage> createState() => _Comments();
}
class _Comments extends State<CommentsPage>{
  get id => id;
  @override
  void initState() {
    var comments = getComments(id);
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
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.face),
                            title: Text(snapshot.data![index].name, style: TextStyle(fontSize: 22),),
                            subtitle: Text(snapshot.data![index].body),
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