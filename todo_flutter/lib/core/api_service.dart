import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000"));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        print('API Error: ${e.response?.statusCode} ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> login(String email, String password) async {
    return await _dio
        .post('/auth/login', data: {'email': email, 'password': password});
  }

  Future<void> register(String email, String password) async {
    await _dio.post('/auth/register', data: {'email': email, 'password': password});
  }

  Future<Response> fetchTasks({int page = 1, int limit = 10}) async {
    return await _dio
        .get('/tasks', queryParameters: {'page': page, 'limit': limit});
  }

  Future<Response> addTask(String title, String description) async {
    return await _dio
        .post('/tasks', data: {'title': title, 'description': description});
  }

  Future<Response> updateTask(
      String id, String title, String description, String status) async {
    return await _dio.put('/tasks/$id',
        data: {'title': title, 'description': description, 'status': status});
  }

  Future<Response> deleteTask(String id) async {
    return await _dio.delete('/tasks/$id');
  }
}
