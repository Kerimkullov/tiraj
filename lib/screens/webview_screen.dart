import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tiraj/components/navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewScreen extends StatefulWidget {
  WebviewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  Future<bool> canBack() async {
    bool canGoBack = await webViewController!.canGoBack();
    String currentURl = webViewController!.getUrl().toString();
    if (currentURl.indexOf("/main") >= 0 || currentURl.indexOf("/info") >= 0) {
      return true;
    } else {
      if (canGoBack) {
        webViewController!.goBack();
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: canBack,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                      initialOptions: options,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      androidOnPermissionRequest:
                          (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![
                          "http",
                          "https",
                          "file",
                          "chrome",
                          "data",
                          "javascript",
                          "about"
                        ].contains(uri.scheme)) {
                          if (await canLaunch(url)) {
                            // Launch the App
                            await launch(
                              url,
                            );
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onLoadError: (controller, url, code, message) {
                        pullToRefreshController.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
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
