
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article/manage_article_controller.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({Key? key}) : super(key: key);
  
  final HtmlEditorController controller = HtmlEditorController();
  var manageArticleController = Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
         onTap: () => controller.clearFocus(),
         child: Scaffold(
          appBar:appBar("نوشتن/ویرایش مقاله "),
          body: SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                    hint: "میتونی مقاله‌تو اینجا بنویسی...",
                    shouldEnsureVisible: true,
                    initialText: manageArticleController.articleInfoModel.value.content!
                  ),
                  callbacks: Callbacks(
                    onChangeContent: (p0) {
                      manageArticleController.articleInfoModel.value.content=p0;
                      log(manageArticleController.articleInfoModel.value.content.toString());
                    },
                  ),
                  
                  )
              ],

          )), 
         ),
    );

  }
}