// ignore_for_file: avoid_print

import 'dart:async';

import 'env_setup.dart';
import 'main_development.dart';
import 'main_production.dart';
import 'main_staging.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1 || !['stag', 'dev', 'prod'].contains(args[0])) {
    print('Usage: `dart bin/server.dart (dev|stag|prod)`');
    return;
  }
  // Set the environment variables based on the "dev" configuration file
  final config = setEnvironmentVariables(args[0]);

  // Access the value of the MY_VAR environment variable
  final dartEnv = config['DART_ENV'];
  final port = int.tryParse(config['port'] as String) ?? 50053;

  switch (dartEnv) {
    case 'production':
      await mainProduction(port);
      break;
    case 'staging':
      await mainStaging(port);
      break;

    default:
      assert(
        dartEnv == 'development',
        'make sure the default is what we want',
      );
      await mainDevelopment(port);
  }
}
