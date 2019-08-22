import 'package:acta/i18n/at_labels.dart';
import 'package:acta/screens/at_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ATWebViewContainer extends StatefulWidget {
  ATWebViewContainer({@required this.url});

  final String url;

  @override
  State<ATWebViewContainer> createState() => _ATWebViewContainerState();
}

class _ATWebViewContainerState extends State<ATWebViewContainer> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ATBaseScreen(
      title: ATLabels.ACTA,
      body: Column(
        children: [
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
            ),
          ),
        ],
      ),
    );
  }
}
