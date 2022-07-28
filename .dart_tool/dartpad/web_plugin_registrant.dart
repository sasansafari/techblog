// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// ignore_for_file: type=lint

import 'package:share_plus_web/share_plus_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  SharePlusPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
