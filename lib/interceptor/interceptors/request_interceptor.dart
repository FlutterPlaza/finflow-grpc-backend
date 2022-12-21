// ignore_for_file: public_member_api_docs, strict_raw_type

import 'dart:async';

import 'package:grpc/grpc.dart';

FutureOr<GrpcError?> requestInterceptor(
  ServiceCall call,
  ServiceMethod method,
) async {
  try {
    // Perform some action here
    return null; // No error occurred
  } catch (e) {
    return GrpcError.unimplemented(
      'An error occurred: $e',
    );
  }
}
