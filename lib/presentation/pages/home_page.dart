import 'package:flutter/material.dart';
import '../../core/api/api_service.dart';
import '../../widgets/post_card.dart';
import 'new_post_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ApiService();
  late Future<List<dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = api.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publicaciones')),
      body: FutureBuilder<List<dynamic>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder:
                  (context, index) => PostCard(post: snapshot.data![index]),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewPostPage()),
          );
          if (result == true) {
            setState(() => posts = api.fetchPosts());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
