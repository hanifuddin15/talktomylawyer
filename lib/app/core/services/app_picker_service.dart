import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AppPicker {
  static final ImagePicker _picker = ImagePicker();

  /// Single image from gallery
  static Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    return image != null ? File(image.path) : null;
  }

  /// Multiple images
  static Future<List<File>> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();

    return images.map((e) => File(e.path)).toList();
  }

  /// Image from camera
  static Future<File?> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    return image != null ? File(image.path) : null;
  }

  /// Single video
  static Future<File?> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    return video != null ? File(video.path) : null;
  }

  /// Video from camera
  static Future<File?> captureVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

    return video != null ? File(video.path) : null;
  }

  /// Single file
  static Future<File?> pickFile({List<String>? allowedExtensions}) async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result == null) return null;

    return File(result.files.single.path!);
  }

  /// Multiple files
  static Future<List<File>> pickFiles({List<String>? allowedExtensions}) async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result == null) return [];

    return result.paths.whereType<String>().map((e) => File(e)).toList();
  }

  /// Images + Videos
  static Future<List<File>> pickMedia() async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'mp4',
        'mov',
        'avi',
        'mkv',
      ],
    );

    if (result == null) return [];

    return result.paths.whereType<String>().map((e) => File(e)).toList();
  }
}
