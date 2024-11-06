import './index.dart';

import '../models/index.dart';

class UserService {
  Future<List<User>> fetchAllUsers() async {
    List<User> users = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model.id;

      final userModels =
          await pb.collection('users').getFullList(filter: "id != '$userId'");

      for (final userModel in userModels) {
        users.add(User.fromJson(userModel.toJson()));
      }
      return users;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
