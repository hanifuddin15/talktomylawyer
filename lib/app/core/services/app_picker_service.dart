import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talktomylawyer/app/core/utils/snackbar.dart';

class AppPicker {
  static final ImagePicker _picker = ImagePicker();

  /// Single image from gallery
  static Future<File?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image != null ? File(image.path) : null;
    } catch (e) {
      // Fallback to FilePicker if ImagePicker channel fails (e.g. unregistered plugin after hot reload)
      try {
        final FilePickerResult? result = await FilePicker.pickFiles(
          type: FileType.image,
        );
        if (result != null && result.files.single.path != null) {
          return File(result.files.single.path!);
        }
      } catch (innerErr) {
        showErrorSnackkbar(
          title: 'Picker Error',
          message: 'Unable to select image. Please restart and clean rebuild the app to load native plugin channels.',
        );
      }
      return null;
    }
  }

  /// Multiple images
  static Future<List<File>> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      return images.map((e) => File(e.path)).toList();
    } catch (e) {
      try {
        final FilePickerResult? result = await FilePicker.pickFiles(
          allowMultiple: true,
          type: FileType.image,
        );
        if (result != null) {
          return result.paths.whereType<String>().map((e) => File(e)).toList();
        }
      } catch (innerErr) {
        showErrorSnackkbar(
          title: 'Picker Error',
          message: 'Unable to select images. Please restart and clean rebuild the app to load native plugin channels.',
        );
      }
      return [];
    }
  }

  /// Image from camera
  static Future<File?> captureImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image != null ? File(image.path) : null;
    } catch (e) {
      showErrorSnackkbar(
        title: 'Camera Error',
        message: 'Unable to launch camera. Please restart and clean rebuild the app to load native plugin channels.',
      );
      return null;
    }
  }

  /// Single video
  static Future<File?> pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      return video != null ? File(video.path) : null;
    } catch (e) {
      try {
        final FilePickerResult? result = await FilePicker.pickFiles(
          type: FileType.video,
        );
        if (result != null && result.files.single.path != null) {
          return File(result.files.single.path!);
        }
      } catch (innerErr) {
        showErrorSnackkbar(
          title: 'Picker Error',
          message: 'Unable to select video. Please restart and clean rebuild the app to load native plugin channels.',
        );
      }
      return null;
    }
  }

  /// Video from camera
  static Future<File?> captureVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
      return video != null ? File(video.path) : null;
    } catch (e) {
      showErrorSnackkbar(
        title: 'Camera Error',
        message: 'Unable to launch video camera. Please restart and clean rebuild the app to load native plugin channels.',
      );
      return null;
    }
  }

  /// Single file
  static Future<File?> pickFile({List<String>? allowedExtensions}) async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: allowedExtensions == null ? FileType.any : FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result == null) return null;

      return File(result.files.single.path!);
    } catch (e) {
      showErrorSnackkbar(
        title: 'File Picker Error',
        message: 'Unable to select file. Please restart and clean rebuild the app.',
      );
      return null;
    }
  }

  /// Multiple files
  static Future<List<File>> pickFiles({List<String>? allowedExtensions}) async {
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: allowedExtensions == null ? FileType.any : FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result == null) return [];

      return result.paths.whereType<String>().map((e) => File(e)).toList();
    } catch (e) {
      showErrorSnackkbar(
        title: 'File Picker Error',
        message: 'Unable to select files. Please restart and clean rebuild the app.',
      );
      return [];
    }
  }

  /// Images + Videos
  static Future<List<File>> pickMedia() async {
    try {
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
    } catch (e) {
      showErrorSnackkbar(
        title: 'Media Picker Error',
        message: 'Unable to select media. Please restart and clean rebuild the app.',
      );
      return [];
    }
  }
}
