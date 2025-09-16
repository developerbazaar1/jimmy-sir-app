import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../local/user_prefrence.dart';
import '../../exceptions/app_exception.dart';
import 'package:file_picker/file_picker.dart';

typedef MapSS = Map<String, String>;
typedef ResponseType = Map<String, dynamic>;
typedef MapSD = Map<String, dynamic>;

class NetworkApiServices {
  // Public method to send HTTP requests
  Future<MapSD> sendHttpRequest({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    MapSS? queryParams,
    Map<String, File>? files,
    String? id,
    bool includeHeaders = true,
    bool showToastOnError = true,
  }) async {
    // Process URL with ID and query parameters
    final processedUrl = _buildUrl(url, id, queryParams);
    // log("👉 FINAL URL-----------------------: $processedUrl");

    try {
      if (files != null && files.isNotEmpty) {
        // Handle file upload requests
        return await _sendMultipartRequest(
          url: processedUrl,
          method: method,
          body: body,
          files: files,
          includeHeaders: includeHeaders,
          showToastOnError: showToastOnError,
        );
      } else {
        // Handle regular requests
        return await _sendRegularRequest(
          url: processedUrl,
          method: method,
          body: body,
          includeHeaders: includeHeaders,
          showToastOnError: showToastOnError,
        );
      }
    } on SocketException {
      Fluttertoast.showToast(msg: "No Internet Connection");
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      Fluttertoast.showToast(msg: "Request timed out. Please try again later.");
      throw FetchDataException("Request timed out. Please try again later.");
    }
  }

  // Private helper to build URL with ID and query parameters
  Uri _buildUrl(Uri url, String? id, MapSS? queryParams) {
    if (id != null && id.isNotEmpty) {
      final pathWithId = '${url.path}/$id';
      url = url.replace(path: pathWithId);
    }
    return queryParams != null
        ? Uri.https(url.authority, url.path, queryParams)
        : url;
  }

  // Private method to send regular HTTP requests
  Future<MapSD> _sendRegularRequest({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool includeHeaders = true,
    bool showToastOnError = true,
  }) async {
    final request = _createRequest(url, method, body);
    // log("request: $request");
    if (includeHeaders) {
      final headers = await UserPreferences().getHeader();
      request.headers.addAll(headers);
    } else {
      request.headers.addAll({'Accept': 'application/json'});
    }

    // request.headers.log("Headers");
    final response = await _sendAndHandleRequest(request);
    // return handleApiResponse(response);
    return handleApiResponse(response, showToastOnError: showToastOnError);
  }

  // Private method to send multipart requests
  Future<MapSD> _sendMultipartRequest({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    required Map<String, File> files,
    bool includeHeaders = true,
    bool showToastOnError = true,
  }) async {
    final request = http.MultipartRequest(method.name.toUpperCase(), url);

    // Add fields to the request
    if (body != null) {
      request.fields.addAll(body);
    }

    // Add files to the request
    for (var entry in files.entries) {
      final file = entry.value;
      final fileStream = http.ByteStream(file.openRead());
      final fileLength = await file.length();
      final multipartFile = http.MultipartFile(
        entry.key,
        fileStream,
        fileLength,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    // Add headers
    if (includeHeaders) {
      final headers = await UserPreferences().getHeader();
      request.headers.addAll(headers);
    } else {
      request.headers.addAll({'Accept': 'application/json'});
    }

    final response = await _sendAndHandleRequest(request);
    return handleApiResponse(response);
  }

  // Private helper to create a request for regular HTTP methods
  http.Request _createRequest(Uri url, HttpMethod method, MapSS? body) {
    final request = http.Request(method.name.toUpperCase(), url);
    if (body != null) {
      request.body = jsonEncode(body);
      request.headers['Content-Type'] = 'application/json';
    }

    // if (body != null) {
    //   if (method == HttpMethod.post || method == HttpMethod.delete) {
    //     // request.bodyFields = body;
    //     request.body = jsonEncode(body);
    //     request.headers['Content-Type'] = 'application/json';
    //   } else if (method == HttpMethod.put) {
    //     request.body = json.encode(body);
    //   }
    // }
    return request;
  }

  // Private helper to send the request and handle streaming
  Future<http.Response> _sendAndHandleRequest(http.BaseRequest request) async {
    final streamedResponse = await request.send().timeout(
      const Duration(seconds: 30),
    );
    return await http.Response.fromStream(streamedResponse);
  }

  MapSD handleApiResponse(
    http.Response response, {
    bool showToastOnError = true,
  }) {
    try {
      final statusCode = response.statusCode;
      final responseJson = statusCode != 500 ? jsonDecode(response.body) : null;

      print("responseBody--------------------: ${response.body}");

      if (statusCode >= 200 && statusCode < 300) {
        print("responseBody--------------------: $statusCode");
        return responseJson;
      } else if (statusCode >= 400 && statusCode < 500) {
        if (responseJson != null && responseJson.containsKey('message')) {
          final dynamic message = responseJson['message'];
          String errorMessage = "An error occurred.";
          if (message is List && message.isNotEmpty) {
            errorMessage = message.join("\n");
          } else if (message is String) {
            errorMessage = message;
          }

          // 🔥 Show error message
          // Fluttertoast.showToast(msg: errorMessage);
          // 🔥 Conditionally show toast
          if (showToastOnError) {
            Fluttertoast.showToast(msg: errorMessage);
          }
          throw ApiException(errorMessage);
        } else {
          throw ApiException("An error occurred. Status code: $statusCode");
        }
      } else if (statusCode == 500) {
        throw InternalSeverException(
          "Internal server error. Please try again.",
        );
      } else {
        throw Exception("Unexpected error. Status code: $statusCode");
      }
    } catch (e) {
      throw FetchDataException("Failed to process response: ${e.toString()}");
    }
  }

  Future sendHttpRequest0({
    required Uri url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    List<Map<String, dynamic>>? files, // List of file maps
    // List<Map<String, String>>? files, // Your current structure
    Map<String, String>? headers,
    String? id,
    bool useToken = false,
    bool useFormData = false,
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw FetchDataException(
        "No Internet Connection. Please check your network settings.",
      );
    }

    if (id != null) {
      url = Uri.parse('$url/$id');
      print('📎 Final URL with ID: $url');
    }

    final uri = queryParams != null && queryParams.isNotEmpty
        ? url.replace(queryParameters: {...url.queryParameters, ...queryParams})
        : url;
    print('🌐 Full URI: $uri');

    final getHeader = await UserPreferences().getHeader();
    print('📦 Headers: $getHeader');

    try {
      http.BaseRequest request;

      if ((files != null && files.isNotEmpty) || useFormData) {
        print('📁 Preparing Multipart Request...');
        if (method == HttpMethod.get) {
          throw FetchDataException(
            "GET method is not supported for multipart requests.",
          );
        }

        http.MultipartRequest multipartRequest = http.MultipartRequest(
          method.name,
          uri,
        )..headers.addAll(getHeader);

        if (body != null) {
          body.forEach((key, value) {
            print(
              "##########################################################################################",
            );
            print(key);

            print(value);
            multipartRequest.fields[key] = value.toString();
          });
        }
        if (files != null) {
          for (var fileMap in files) {
            for (var entry in fileMap.entries) {
              final key = entry.key;
              final path = entry.value;
              print("🖼️ Adding file to multipart - key: $key, path: $path");
              multipartRequest.files.add(
                await http.MultipartFile.fromPath(key, path),
              );
            }
          }
        }

        // for (var file in files) {
        //   String key = file.keys.first;
        //   String path = file.values.first;
        //   print("🖼️ Adding file to multipart - key: $key, path: $path");
        //   multipartRequest.files
        //       .add(await http.MultipartFile.fromPath(key, path));
        // }

        print("🧾 Multipart Fields: ${multipartRequest.fields}");
        request = multipartRequest;
      } else {
        print('📤 Preparing JSON Request...');
        http.Request httpRequest = http.Request(method.name, uri)
          ..headers.addAll(getHeader);

        if (method != HttpMethod.get && body != null) {
          httpRequest.headers["Content-Type"] = "application/json";
          httpRequest.body = jsonEncode(body);
          print("🧾 JSON Body: ${httpRequest.body}");
        }

        request = httpRequest;
      }

      print("🚀 Sending ${method.name} request to: $uri");
      http.StreamedResponse streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      http.Response response = await http.Response.fromStream(streamedResponse);

      print("📬 Status Code: ${response.statusCode}");
      print("📨 Raw Response Body: ${response.body}");

      dynamic responseJson = errorHandling(response);
      print("✅ Parsed Response JSON: $responseJson");

      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw FetchDataException("Request timed out. Please try again later.");
    } catch (e) {
      print('❌ Error occurred: $e');
      print('❌ Headers received (if any): ${HttpHeaders.responseHeaders}');
      throw FetchDataException(e.toString());
    }
  }

  Future<ResponseType> sendHttpRequest2({
    required Uri url,
    required HttpMethod method,
    MapSS? body,
    bool useHeaders = false,
    List<Map<String, String>>? files,
    String? id,
  }) async {
    if (id != null) {
      print(id);
      url = Uri.parse(url.toString() + id);
      print(url);
    }
    final String? token = await UserPreferences().getToken();
    print(token);
    final headers = {"Authorization": "Bearer $token"};
    dynamic request;
    try {
      switch (method) {
        case HttpMethod.get:
          request = http.Request('GET', url);
          if (useHeaders) {
            request.headers.addAll(headers);
          }
          break;
        case HttpMethod.post:
          request = http.MultipartRequest('POST', url);

          if (body != null) {
            request.fields.addAll(body);
          }

          if (files != null && files.isNotEmpty) {
            for (var file in files) {
              String key = file.keys.first;
              String value = file.values.first;
              request.files.add(await http.MultipartFile.fromPath(key, value));
            }
          }
          if (useHeaders) {
            request.headers.addAll(headers);
          }
          break;
        case HttpMethod.put:
          request = http.MultipartRequest('PUT', url);

          print("request: $request");
          print(
            "_____________________+++++++++++++++++++++++++++++++++++++++++++++++++++",
          );

          if (body != null) {
            request.fields.addAll(body);
          }

          // request = http.Request('PUT', url)..body = json.encode(body);

          if (files != null && files.isNotEmpty) {
            print(files.length);
            print(files);
            print("_________________________________________________");
            for (var file in files) {
              String key = file.keys.first;
              String value = file.values.first;
              request.files.add(await http.MultipartFile.fromPath(key, value));
            }
          }
          if (useHeaders) {
            request.headers.addAll(headers);
          }
          break;
        case HttpMethod.delete:
          request = http.Request('DELETE', url)..body = json.encode(body);
          if (useHeaders) {
            request.headers.addAll(headers);
          }
          break;
      }
      final streamedResponse = await request.send();
      // log("body-----------------------AAAAAAAAAAAAAAAAAAAAAAAAAAAA: $body,$files");

      print('streamedResponse');
      print(streamedResponse);
      print(streamedResponse.statusCode);
      print(streamedResponse.headers);
      print(streamedResponse.request);
      print(
        "(((((((((((((((((((((((((((((((((((((((((((((((((((((((object)))))))))))))))))))))))))))))))))))))))))))))))))))))))",
      );
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      print(response.statusCode);
      print(response.headers);
      print(response.request);
      print("_______________________________________________");
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      throw TimeoutException("Request timed out");
    } catch (e) {
      throw (e.toString());
    }
  }

  ResponseType _processResponse(http.Response response) {
    final code = response.statusCode;
    print(response.statusCode);
    final responseJson = code != 500 ? jsonDecode(response.body) : null;
    switch (code) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson['message']);
      case 401:
        print(responseJson['message']);
        throw UnauthorizedException(responseJson['message']);
      case 404:
        // throw UnauthorizedException(responseJson['message']);
        return responseJson;
      case 500:
        throw UnauthorizedException(responseJson['message']);
      default:
        throw FetchDataException("Unexpected status code: $code");
    }
  }

  Future sendHttpRequest1({
    required Uri url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, File>? files, // multiple files as Map with fieldName => File
    String? id,
    bool useToken = false,
  }) async {
    print("[DEBUG 1] sendHttpRequest1 called with:");
    print("URL: $url");
    print("Method: $method");
    print("ID: $id");
    print("Query Params: $queryParams");
    print("Body: $body");
    print("Files count: ${files?.length ?? 0}");

    if (id != null) {
      url = Uri.parse(url.toString() + "/$id");
      print("[DEBUG 2] URL with ID appended: $url");
    }

    final uri = queryParams != null && queryParams.isNotEmpty
        ? url.replace(queryParameters: {...url.queryParameters, ...queryParams})
        : url;
    print("[DEBUG 3] Final URI with query params: $uri");

    final getHeader = await UserPreferences().getHeader1(useToken);
    print("[DEBUG 4] Headers: $getHeader");

    try {
      // Handle Multipart Request
      if (files != null &&
          files.isNotEmpty &&
          (method == HttpMethod.post || method == HttpMethod.put)) {
        var request = http.MultipartRequest(method.name.toUpperCase(), uri);
        request.headers.addAll(getHeader);

        // Add files
        for (var entry in files.entries) {
          File file = entry.value;
          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            entry.key,
            stream,
            length,
            filename: file.path.split('/').last,
          );

          request.files.add(multipartFile);
          print(
            "[DEBUG 5] Added file: ${multipartFile.filename} with field: ${entry.key}, size: $length bytes",
          );
        }

        // ✅ FIX: Add only non-null fields
        if (body != null) {
          body.forEach((key, value) {
            if (value != null) {
              if (value is List || value is Map) {
                request.fields[key] = jsonEncode(value);
              } else {
                request.fields[key] = value.toString();
              }
              print("[DEBUG 6] Added field: $key = ${request.fields[key]}");
            } else {
              print("[DEBUG SKIP] Skipped null field: $key");
            }
          });
        }

        print("[DEBUG 7] Sending multipart request...");
        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 30),
        );
        var response = await http.Response.fromStream(streamedResponse);

        print("[DEBUG 8] Response status code: ${response.statusCode}");
        print("[DEBUG 9] Response body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed request with status: ${response.statusCode}');
        }
      }
      // Handle JSON Request
      else {
        late final http.Request request;

        switch (method) {
          case HttpMethod.get:
            request = http.Request('GET', uri);
            break;
          case HttpMethod.post:
            request = http.Request('POST', uri);
            break;
          case HttpMethod.put:
            request = http.Request('PUT', uri);
            break;
          case HttpMethod.delete:
            request = http.Request('DELETE', uri);
            break;
        }

        if (body != null) request.body = jsonEncode(body);
        request.headers.addAll({
          ...getHeader,
          "Content-Type": "application/json",
        });

        print(
          "[DEBUG 10] Sending normal request: ${request.method} ${request.url}",
        );
        print("[DEBUG 11] Headers: ${request.headers}");
        print("[DEBUG 12] Body: ${request.body}");

        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 30),
        );
        var response = await http.Response.fromStream(streamedResponse);

        print("[DEBUG 13] Response status code: ${response.statusCode}");
        print("[DEBUG 14] Response body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonDecode(response.body);
        } else {
          throw Exception('Failed request with status: ${response.statusCode}');
        }
      }
    } on SocketException catch (e) {
      print("[DEBUG ERROR] SocketException: $e");
      throw FetchDataException("No Internet Connection");
    } on TimeoutException catch (e) {
      print("[DEBUG ERROR] TimeoutException: $e");
      throw FetchDataException("Request timed out. Please try again later.");
    } catch (e, stackTrace) {
      print("[DEBUG ERROR] Exception: $e");
      print(stackTrace);
      throw FetchDataException(e.toString());
    }
  }

  //----------------------------- Ashu: Generic HTTP Request Handler with Path Param -----------------------------
  Future<Map<String, dynamic>> sendHttpRequestWithPathParam({
    required Uri url, // Base URL without ID
    required String pathParam, // ID to append at end
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, File>? files,
    Map<String, dynamic>? queryParams,
    bool useToken = false,
  }) async {
    try {
      // Append ID to URL
      final fullUrl = Uri.parse("${url.toString()}/$pathParam");

      // Add query params if needed
      final uriWithQuery = queryParams != null && queryParams.isNotEmpty
          ? fullUrl.replace(
              queryParameters: {...fullUrl.queryParameters, ...queryParams},
            )
          : fullUrl;

      print("[DEBUG 1] Final Request URL: $uriWithQuery");

      final headers = await UserPreferences().getHeader1(useToken);
      print("[DEBUG 2] Headers: $headers");

      if (files != null &&
          files.isNotEmpty &&
          (method == HttpMethod.post || method == HttpMethod.put)) {
        final request = http.MultipartRequest(
          method.name.toUpperCase(),
          uriWithQuery,
        );
        request.headers.addAll(headers);

        for (var entry in files.entries) {
          final file = entry.value;
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          final multipartFile = http.MultipartFile(
            entry.key,
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
          print("[DEBUG 3] Added file: ${multipartFile.filename}");
        }

        if (body != null) {
          body.forEach((key, value) {
            request.fields[key] = value is String ? value : jsonEncode(value);
          });
          print("[DEBUG 4] Fields: ${request.fields}");
        }

        final responseStream = await request.send();
        final response = await http.Response.fromStream(responseStream);

        print(
          "[DEBUG 5] Multipart Response: ${response.statusCode} ${response.body}",
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return jsonDecode(response.body);
        } else {
          throw Exception("Failed with status: ${response.statusCode}");
        }
      }

      final request = http.Request(method.name.toUpperCase(), uriWithQuery);
      request.headers.addAll({...headers, "Content-Type": "application/json"});

      if (body != null) {
        request.body = jsonEncode(body);
        print("[DEBUG 6] Request Body: ${request.body}");
      }

      print("[DEBUG 7] Sending ${request.method} request to: $uriWithQuery");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("[DEBUG 8] Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed with status: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("[DEBUG ERROR] $e");
      print("[DEBUG STACKTRACE] $stackTrace");
      throw Exception("sendHttpRequestWithPathParam failed: $e");
    }
  }

  Map<String, dynamic> errorHandling(http.Response response) {
    UserPreferences userPreferences = UserPreferences();
    final code = response.statusCode;
    dynamic responseJson = code != 500 ? jsonDecode(response.body) : null;
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        if (responseJson is Map<String, dynamic> &&
            responseJson.containsKey('message')) {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
        return responseJson;
      case 401:
        if (responseJson is Map<String, dynamic> &&
            responseJson.containsKey('message')) {
          userPreferences.removeToken();
          userPreferences.removeDeviceToken();

          responseJson['message'];
        }
        return responseJson;
      case 403:
        return responseJson;
      case 404:
        throw ApiException(responseJson['message']);
      case 500:
        throw InternalSeverException("");
      default:
        return responseJson;
    }
  }
}
