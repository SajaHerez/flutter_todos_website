import 'package:dio/dio.dart';

import 'dio_client.dart';

class PercentageAPI {
  late DioClient client;
 PercentageAPI(this.client);

  Future<Response> completedTask({
    required String path,
     required int user_id,
    
  }) async {
    final response = await client.dio.get('$path/$user_id',);
    return response;
  }

Future<Response> dailyTask({
   required String path,
   required int user_id,
   required String date
  }) async {
    final response = await client.dio.post('$path/$user_id',data: {
      'date': date
    });
    return response;
  }

}
