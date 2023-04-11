 import 'package:file_picker/file_picker.dart';
 import 'package:get/get.dart';
import 'package:tec/controller/file_controller.dart';
 
FilePickerController  filePickerController = Get.put(FilePickerController());
  
Future pickFile() async{

  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

  filePickerController.file.value = result!.files.first;
  return filePickerController.file.value;
}
Future audioFile()async{
  
  FilePickerController filePickerController = Get.put(FilePickerController());
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio );
  filePickerController.file.value = result!.files.first;
}