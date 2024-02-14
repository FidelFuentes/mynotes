import 'package:mynotes/services/auth/auth_user.dart';

abstract class AuthProvider{

  Future<void> initialize();

  AuthUser? get currentUser; //any auth provider firebase, google etc
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}