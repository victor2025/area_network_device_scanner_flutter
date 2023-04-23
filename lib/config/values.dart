import 'package:area_network_device_scanner/config/strings.dart';
import 'package:area_network_device_scanner/utils/ip_utils.dart';
import 'package:area_network_device_scanner/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class StyleConfigs{

  static TextStyle alertTitleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static MarkdownConfig markdownConfig = MarkdownConfig(
    configs: [
      const H1Config(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
      ),
      const H2Config(
        style: TextStyle(
          fontSize: 12
        )
      ),
      const PConfig(
        textStyle: TextStyle(fontSize: 10)
      )
    ]
  );
}