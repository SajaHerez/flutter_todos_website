import 'package:dio/dio.dart';

import '../../util/error/serverError.dart';
import '../../util/widgets/snackbar.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.data['message'] !=null){
    MySnackBar.showInSnackBar(response.data['message']);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final error = DioExceptions.fromDioError(err);
    MySnackBar.showInSnackBar(error.message);
  }
}
