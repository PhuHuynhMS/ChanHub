import 'package:pocketbase/pocketbase.dart';

import '../models/index.dart';
import './index.dart';

class AuthService {
  void Function(User? user)? onAuthChanged;

  AuthService({this.onAuthChanged}) {
    if (onAuthChanged != null) {
      PocketBaseService.getInstance().then((pocketBase) {
        pocketBase.authStore.onChange.listen((AuthStoreEvent event) {
          onAuthChanged!(
            event.model != null ? User.fromJson(event.model!.toJson()) : null,
          );
        });
      });
    }
  }

  Future<bool> signup({
    required String email,
    required String password,
    required String username,
    String? jobTitle,
    String? fullname,
  }) async {
    final pocketBase = await PocketBaseService.getInstance();
    final body = <String, dynamic>{
      'username': username,
      'email': email,
      'emailVisibility': true,
      'password': password,
      'passwordConfirm': password,
      'fullname': fullname,
      'jobTitle': jobTitle,
    };

    try {
      await pocketBase.collection('users').create(body: body);
      await pocketBase.collection('users').requestVerification(email);
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final pocketBase = await PocketBaseService.getInstance();
    try {
      final authRecord = await pocketBase
          .collection('users')
          .authWithPassword(email, password);

      return User.fromJson(authRecord.record!.toJson());
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> logout() async {
    final pb = await PocketBaseService.getInstance();
    pb.authStore.clear();
  }

  Future<User?> getUserFromStore() async {
    final pb = await PocketBaseService.getInstance();
    final model = pb.authStore.model;

    if (model == null) {
      return null;
    }

    return User.fromJson(model.toJson());
  }

  Future<void> requestPasswordReset(String email) async {
    final pb = await PocketBaseService.getInstance();

    try {
      await pb.collection('users').requestPasswordReset(email);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
