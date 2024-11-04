import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './local_storage_service.dart';

class PocketBaseService {
  static PocketBase? _pocketBase;
  static const String _localAuthKey = 'pb_auth';

  static Future<PocketBase> getInstance() async {
    if (_pocketBase != null) {
      return _pocketBase!;
    }

    final localStorage = await LocalStorageService.getInstance();
    final baseUrl = dotenv.env['POCKETBASE_URL'] ?? 'http://10.0.2.2:8090';
    final authStore = AsyncAuthStore(
      save: (String data) async => localStorage.set(_localAuthKey, data),
      initial: localStorage.get(_localAuthKey),
    );

    _pocketBase = PocketBase(baseUrl, authStore: authStore);
    return _pocketBase!;
  }
}

extension PocketBaseImageInJson on Map<String, dynamic> {
  String? getImageUrl(String path) {
    if (this[path] == null || (this[path] as String).isEmpty) {
      return null;
    }
    return "${dotenv.env['POCKETBASE_URL']}/api/files/${this['collectionId']}/${this['id']}/${this[path]}";
  }

  List<String> getImageUrls(String path) {
    if (this[path] == null || (this[path] as List).isEmpty) {
      return [];
    }
    return (this[path] as List).map((e) {
      return "${dotenv.env['POCKETBASE_URL']}/api/files/${this['collectionId']}/${this['id']}/${e}";
    }).toList();
  }
}
