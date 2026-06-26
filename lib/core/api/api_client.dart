import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_interceptor.dart';

/// Singleton Dio client.
/// Pakai [ApiClient.instance] di repository.
class ApiClient {
  ApiClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final baseUrl = dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:8000';

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false, // jangan log Authorization header ke console
      ),
    ]);

    return dio;
  }

  /// Reset instance (dipakai saat logout)
  static void reset() => _instance = null;
}
