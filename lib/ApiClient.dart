import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  // 기본 URL 설정
  final String baseUrl;

  ApiClient({required this.baseUrl}) {
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // 요청 전에 수행할 작업 (예: 헤더 추가, 로깅)
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options); // 요청 진행
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // 응답 받은 후 수행할 작업 (예: 데이터 변환, 로깅)
        print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response); // 응답 진행
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        // 에러 발생 시 수행할 작업 (예: 에러 처리, 재시도)
        print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        return handler.next(e); // 에러 진행
      },
    ));
  }

  // GET 요청
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // POST 요청
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // PUT 요청
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE 요청
  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  // 에러 처리
  dynamic _handleError(DioError error) {
    String errorDescription = "";
    if (error.type == DioErrorType.connectionTimeout) {
      errorDescription = "연결 시간 초과";
    } else if (error.type == DioErrorType.receiveTimeout) {
      errorDescription = "응답 시간 초과";
    } else if (error.response != null) {
      errorDescription = "오류 발생: ${error.response!.statusCode} - ${error.response!.data}";
    } else {
      errorDescription = "알 수 없는 오류 발생: ${error.message}";
    }
    return Exception(errorDescription);
  }
}