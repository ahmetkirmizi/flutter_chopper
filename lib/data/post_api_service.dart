import 'package:chopper/chopper.dart';
import 'package:chopper_example/data/built_value.converter.dart';
import 'package:chopper_example/model/built_post.dart';
import 'package:built_collection/built_collection.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [
        HttpLoggingInterceptor()
      ],
    );
    return _$PostApiService(client);
  }
}
