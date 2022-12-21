// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:finflow_backend/interceptor/interceptors.dart';
import 'package:finflow_backend/services/auth/services/auth_service.dart';
import 'package:grpc/grpc.dart';

Future<void> mainStaging(int port) async {
  final certFile = File('server.crt');
  final keyFile = File('server.key');
  final server = Server(
    [UserAuthService()],
    [
      errorInterceptor,
      serverInterceptor,
      streamInterceptor,
      unaryInterceptor,
      responseInterceptor,
      requestInterceptor,
      clientInterceptor
    ],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );

  // Start the server in a zone that catches and logs any unhandled exceptions
  await runZonedGuarded(() async {
    await server.serve(
      // address: ,
      security: ServerTlsCredentials(
        certificate: certFile.readAsBytesSync(),
        privateKey: keyFile.readAsBytesSync(),
      ),

      port: port,
    );
    print('Production Server listening on port ${server.port}...');
  }, (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
    print('Unhandled exception: $error\n$stackTrace');
  });
}
