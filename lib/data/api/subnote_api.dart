import 'package:dio/dio.dart';

import 'dio_client.dart';

class SubNoteAPI {
  late DioClient client;
  SubNoteAPI(this.client);

  Future<Response> addSubNote(
      {required String path,
      required String user_id,
      required String note_id,
      required String title,
      required String completedAt,
      required String createdAt,
      required bool isCancelled,
      required bool isDone}) async {
    final response = await client.dio.post('$path/$user_id/$note_id', data: {
      'title': title,
      'completedAt': completedAt,
      'createdAt': createdAt,
      'isCancelled': isCancelled,
      'isDone': isDone
    });
    return response;
  }

  Future<Response> updateSubNote(
      {required String path,
      required String title,
      required String createdAt,
      required String completedAt,
      required bool isCancelled,
      required bool isDone,
      required String user_id,
      required String note_id,
      required String subNote_id}) async {
    final response =
        await client.dio.put('$path/$user_id/$note_id/$subNote_id', data: {
      'title': title,
      'createdAt': createdAt,
      'completedAt': completedAt,
      'isCancelled': isCancelled,
      'isDone': isDone
    });
    print(response.data);
    return response;
  }

  Future<Response> deleteSubNote(
      {required String path,
      required String user_id,
      required String note_id,
      required String subNote_id}) async {
    final response =
        await client.dio.delete('$path/$user_id/$note_id/$subNote_id');
    return response;
  }
}
