import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tec/constant/my_colors.dart';

import '../../component/my_component.dart';
import '../../controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatefulWidget {
  const ArticleContentEditor({Key? key}) : super(key: key);

  @override
  _ArticleContentEditorState createState() => _ArticleContentEditorState();
}

class _ArticleContentEditorState extends State<ArticleContentEditor> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();
  // var articleManageController = Get.find<ManageArticleController>();
  var articleManageController = Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: appBar("ویرایش مقاله"),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
             
                htmlEditorOptions:   HtmlEditorOptions(
                  hint: 'Your text here...',
                  shouldEnsureVisible: true,
                  initialText:  articleManageController.articleInfoModel.value.content,
                  
                ),
                callbacks: Callbacks(
                  onChangeContent: (p0) {
                                            articleManageController.articleInfoModel.update((val) {
                          val!.content = p0;
                        });
                  },
                ),
                htmlToolbarOptions: const HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor, //by default
                  toolbarType: ToolbarType.nativeScrollable,
                  defaultToolbarButtons: [
                    StyleButtons(),
                    FontSettingButtons(),
                    FontButtons(),
                    ColorButtons(),
                    ListButtons(),
                    ParagraphButtons(),
                    OtherButtons(),
                  ],
                  toolbarItemHeight: 60,

                  buttonColor: SolidColors.primeryColor,
                  dropdownFocusColor: SolidColors.colorTitle,
                  // ignore: prefer_const_constructors
                  textStyle: TextStyle(
                      fontFamily: 'dana',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SolidColors.textTitle),
                  dropdownBackgroundColor: SolidColors.lightText, //by default
                ),
                plugins: [
                  SummernoteAtMention(
                      getSuggestionsMobile: (String value) {
                        var mentions = <String>['test1', 'test2', 'test3'];
                        return mentions
                            .where((element) => element.contains(value))
                            .toList();
                      },
                      mentionsWeb: ['test1', 'test2', 'test3'],
                      onSelect: (String value) {
                        print(value);
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        controller.undo();
                      },
                      child: const Text('Undo',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        controller.clear();
                      },
                      child: const Text('Reset',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var txt = await controller.getText();
                        if (txt.contains('src=\\"data:')) {
                          txt =
                              '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                        }

                        Get.back();
                        log( articleManageController.articleInfoModel.value.content.toString());
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary),
                      onPressed: () {
                        controller.redo();
                      },
                      child: const Text(
                        'Redo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
