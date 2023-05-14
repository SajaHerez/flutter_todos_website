import 'package:dio/dio.dart';

import 'dio_client.dart';

class AuthAPI {
  late DioClient client;
  AuthAPI(this.client);

  Future<Response> signUp({
    required String path,
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await client.dio.post(path, data: {
      'email': email,
      'password': password,
      'name': name,
    });
    return response;
  }


 Future<Response> signIn({
    required String path,
    required String email,
    required String password,
  }) async {
    final response = await client.dio.post(path, data: {
      'email': email,
      'password': password,
    });
    return response;
  }


Future<Response> singOut({
    required String path,
    required String user_id 
  }) async {
    final response = await client.dio.get('$path/$user_id ');
    return response;
  }
}
