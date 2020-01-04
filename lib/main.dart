import 'package:chopper_example/data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => PostApiService.create(),
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(title: 'Material App', home: HomePage()),
    );
  }
}
