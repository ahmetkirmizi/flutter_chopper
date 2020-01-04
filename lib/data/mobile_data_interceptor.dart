import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class MobileDataInterceptor implements RequestInterceptor{
  @override
  Future<Request> onRequest(Request request) async {
   final connectivirtResult = await Connectivity().checkConnectivity();

   final isMobile = connectivirtResult == ConnectivityResult.mobile;
   final isLargeFile = request.url.contains(RegExp(r'(/large|/video|/post)'));
   //example http://api.com/video/asd.mp4

   if (isMobile && isLargeFile) {
     throw MobileDataCostException();
   }
   return request;
  }

}

class MobileDataCostException implements Exception{
  final message = 'Dosya boyutu büyük mobile veri kullanıyorsunuz!';

  @override
  String toString() => message;
}