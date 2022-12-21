// ignore_for_file: public_member_api_docs

import 'package:finflow_backend/generated/auth/services/auth.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class UserAuthService extends UserAuthServiceBase {
  final Map<String, User> users = {};

  @override
  Future<Empty> createUser(ServiceCall call, CreateUserRequest request) async {
    // Validate the request.
    if (request.id.isEmpty || request.name.isEmpty || request.email.isEmpty) {
      throw GrpcError.invalidArgument('ID, name, and email must not be empty.');
    }

    // Check if the user already exists.
    if (users.containsKey(request.id)) {
      throw GrpcError.alreadyExists('User already exists.');
    }

    // Create a new user.
    final user = User()
      ..id = request.id
      ..name = request.name
      ..email = request.email;
    users[user.id] = user;

    // Return an empty response to indicate success.
    return Empty();
  }

  @override
  Future<User> getUser(ServiceCall call, GetUserRequest request) async {
    // Validate the request.
    if (request.id.isEmpty) {
      throw GrpcError.invalidArgument('ID must not be empty.');
    }

    // Retrieve the user.
    final user = users[request.id];
    if (user == null) {
      throw GrpcError.notFound('User not found.');
    }

    // Return the user.
    return user;
  }

  @override
  Future<Empty> signUp(ServiceCall call, SignUpRequest request) async {
    // Validate the request.
    if (request.email.isEmpty || request.password.isEmpty) {
      throw GrpcError.invalidArgument('Email and password must not be empty.');
    }

    // // Check if the email is already in use.
    // if (await emailExists(request.email)) {
    //   throw GrpcError.alreadyExists('Email already in use.');
    // }

    // // Create a new user account.
    // final user = User(
    //   email: request.email,
    //   password: request.password,
    // );
    // await createUser(user);

    // // Generate a JWT for the new user.
    // final jwt = generateJWT(user);

    // // Store the JWT in a secure location.
    // await storeJWT(user.id, jwt);

    // Return an empty response to indicate success.
    return Empty();
  }

  @override
  Future<SignInResponse> signIn(ServiceCall call, SignInRequest request) async {
    // Validate the request.
    if (request.email.isEmpty || request.password.isEmpty) {
      throw GrpcError.invalidArgument('Email and password must not be empty.');
    }

    // // Sign in the user.
    // final user = await signInUser(request.email, request.password);
    // if (user == null) {
    //   throw GrpcError.notFound('Invalid email or password.');
    // }

    // // Retrieve the JWT for the user from the secure location.
    // final jwt = await retrieveJWT(user.id);

    // Return the JWT in the response.
    return SignInResponse();
    // return SignInResponse()..jwt = jwt;
  }
}
