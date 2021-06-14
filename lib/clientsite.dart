import 'dart:io';

import 'package:diaa_task/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ClientSite extends StatefulWidget {
  @override
  _ClientSiteState createState() => _ClientSiteState();
}

class _ClientSiteState extends State<ClientSite>
{
  String phone = "";
  String message = "";
  String url = "";

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    NotificationCenter(context).initConfigure();

  }

  _launchURL({bool isPhoneCall, bool isIntigram = false}) async {
    if (isIntigram == false) {
      if (isPhoneCall) {
        url = "tel://$phone";
      } else {
        url = "whatsapp://send?phone=+$phone&text=$message";
      }
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff44235),
        title: Text(
          "عقار الكويت",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:Stack(
        children: [

          WebView(
            initialUrl: 'https://q8aqar.com/app/1/',
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              print("request url : ${request.url}");
              if (request.url.contains("https://wa.me/")) {
                phone = request.url
                    .toString()
                    .split("https://wa.me/")[1]
                    .split("?text")[0];
                message = request.url.toString().split("text=")[1];
                _launchURL(isPhoneCall: false);
                return NavigationDecision.prevent;
              } else if (request.url.contains("tel:")) {
                print("phonephone ");
                phone = request.url.toString().split("tel:")[1];
                _launchURL(isPhoneCall: true);

                // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (request.url.contains("instagram") ||
                  request.url.contains("twitter") ||
                  request.url.contains("mailto")) {
                url = request.url;
                _launchURL(isPhoneCall: false, isIntigram: true);
                return NavigationDecision.prevent;
              }

              else {
                return NavigationDecision.navigate;
              }
            },
          ),
        ],
      ),
    );
  }
}
