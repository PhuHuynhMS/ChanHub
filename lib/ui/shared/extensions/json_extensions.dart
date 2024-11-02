import 'package:flutter_dotenv/flutter_dotenv.dart';

extension PocketBaseImageInJson on Map<String, dynamic> {
  String? getImageUrl(String path) {
    if (this[path] == null || (this[path] as String).isEmpty) {
      return null;
    }
    return "${dotenv.env['POCKETBASE_URL']}/api/files/${this['collectionId']}/${this['id']}/${this[path]}";
  }
}
