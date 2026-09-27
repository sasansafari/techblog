import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tec/controller/file_controller.dart';

FilePickerController _filePickerController = Get.put(FilePickerController());
Future pickFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null && result.files.isNotEmpty) {
    _filePickerController.file.value = result.files.first;
  }
}

Future audioFile() async {
  FilePickerController filePickerController = Get.put(FilePickerController());
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.audio);
  if (result != null && result.files.isNotEmpty) {
    filePickerController.file.value = result.files.first;
  }
}
