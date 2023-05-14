import 'package:dio/dio.dart';
import 'package:flutter_todos_website/data/api/dio_client.dart';
import 'package:flutter_todos_website/data/api/note_api.dart';
import 'package:flutter_todos_website/data/local/local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/auth_api.dart';
import '../data/api/percentage_api.dart';
import '../data/api/subnote_api.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioClient>(DioClient(getIt<Dio>()));
  getIt.registerSingleton<AuthAPI>(AuthAPI(getIt<DioClient>()));
  getIt.registerSingleton<NoteAPI>(NoteAPI(getIt<DioClient>()));
  getIt.registerSingleton<SubNoteAPI>(SubNoteAPI(getIt<DioClient>()));
  getIt.registerSingleton<PercentageAPI>(PercentageAPI(getIt<DioClient>()));
  await _initSharedPref();
  getIt.registerSingletonAsync<LocalStorage>(
      () async => LocalStorage(getIt<SharedPreferences>()));
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
