
import 'package:chopper/chopper.dart';
import 'package:chopper_example/data/post_api_service.dart';
import 'package:chopper_example/model/built_post.dart';
import 'package:chopper_example/single_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:built_collection/built_collection.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chopper Example'),
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () async {
            final newPost = BuiltPost((b) => b 
            ..title = 'New Title'
            ..body = 'New Body');
            final response = await Provider.of<PostApiService>(context)
                .postPost(newPost);

            print(response.body);
          },
        ),
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response<BuiltList<BuiltPost>>>(
        future: Provider.of<PostApiService>(context).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final  posts = snapshot.data.body;
            return _buildPosts(context, posts);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  ListView _buildPosts(BuildContext context, BuiltList<BuiltPost> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context,index){
        return Card(elevation: 4,
        child: ListTile(
          title: Text(
            posts[index].title,
          style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(posts[index].body),
          onTap: () =>_navigatePosts(context,posts[index].id),
                  ),
                  );
                },
              );
            }
          
    void _navigatePosts(BuildContext context, int id) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context)=> SinglePostPage(postId:id),
        )
      );
    }
}
