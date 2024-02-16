import 'package:image_picker/image_picker.dart';

class Post {
  final String location;
  final DateTime lastUpdate;
  XFile? image;
  final String initiator;
  final int id;

  Post({
    required this.location,
    required this.initiator,
    required this.lastUpdate,
    this.image,
    required this.id,
  });
}

