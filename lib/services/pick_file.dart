import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tech/controller/file_controller.dart';

FilePickerController _filePickerController = Get.put(FilePickerController());
Future pickFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null && result.files.isNotEmpty) {
    _filePickerController.file.value = result.files.first;
  } else {}
}

Future audioFile() async {
  FilePickerController filePickerController = Get.put(FilePickerController());
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.audio);
  filePickerController.file.value = result!.files.first;
}
