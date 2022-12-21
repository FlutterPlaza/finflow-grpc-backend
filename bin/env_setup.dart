import 'dart:convert';
import 'dart:io';

Map<String, dynamic> setEnvironmentVariables(String environment) {
  // Read the configuration file for the specified environment
  final configFile = File('config.$environment.json');
  final configString = configFile.readAsStringSync();

  // Parse the JSON and set the environment variables
  final config = jsonDecode(configString) as Map<String, dynamic>;
  // for (final key in config.keys) {
  //   Platform.setEnvironment(). = (config[key] ?? '') as String;
  // }

  return config;
}
