import 'package:dio/dio.dart';

import 'dio_client.dart';

class NoteAPI {
  late DioClient client;
  NoteAPI(this.client);

  Future<Response> createNote({
    required String path,
     required int userId,
    required String title,
    required String completedAt,
    required String createdAt,
    required  bool isCancelled,
    required  bool isDone
  }) async {
    final response = await client.dio.post('$path/$userId', data: {
      'title': title,
      'completedAt': completedAt,
      'createdAt': createdAt,
      'isCancelled':isCancelled,
      'isDone':isDone
    });
    return response;
  }


 Future<Response> getNote({
    required String path,
    required int user_id,
  }) async {
    final response = await client.dio.get('$path/$user_id');
    return response;
  }


Future<Response> updateNote({
   required String path,
    required String title,
    required String completedAt,
    required  bool isCancelled,
    required  bool isDone,
    required int user_id,
    required int note_id 
  }) async {
    final response = await client.dio.put('$path/$user_id/$note_id',data: {
      'title': title,
      'completedAt': completedAt,
      'isCancelled':isCancelled,
      'isDone':isDone
    });
    return response;
  }


  Future<Response> deleteNote({
    required String path,
    required int user_id,
    required int note_id 
  }) async {
    final response = await client.dio.delete('$path/$user_id/$note_id');
    return response;
  }
}
