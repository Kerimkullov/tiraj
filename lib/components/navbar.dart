import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiraj/const/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/webview_screen.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void exitApp() => exit(0);

  void openFacebook() async {
    if (await canLaunch('fb://profile/tiraj.kg')) {
      launch('fb://profile/tiraj.kg');
    } else {
      launch('https://www.facebook.com/tiraj.kg');
    }
  }

  void openTwitter() async {
    if (await canLaunch('https://twitter.com/tiraj_kg')) {
      launch('https://twitter.com/tiraj_kg');
    }
  }

  void openInstagram() async {
    launch('https://www.instagram.com/tiraj_kg/');
  }

  void openYoutube() async {
    if (await canLaunch(
        'youtube://www.youtube.com/channel/UCTrFiGn9-hEO1swddesL5wA')) {
      launch('youtube://www.youtube.com/channel/UCTrFiGn9-hEO1swddesL5wA');
    } else {
      launch('https://www.youtube.com/channel/UCTrFiGn9-hEO1swddesL5wA');
    }
  }

  void openFeed() async {
    launch('https://tiraj.kg/feed/');
  }

  void openTelegram() async {
    launch('https://t.me/tiraj_news');
  }

  void openWhatsApp() async {
    if (await canLaunch('https://api.whatsapp.com/send?phone=996701517777=')) {
      launch('https://api.whatsapp.com/send?phone=996701517777=');
    } else {
      launch(
          'https://api.whatsapp.com/send/?phone=996701517777&text&app_absent=0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Image.asset('assets/images/logo.png'),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.facebook,
              color: TirajColors.iconInActive,
            ),
            title: Text('Facebook'),
            onTap: openFacebook,
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.twitter,
              color: TirajColors.iconInActive,
            ),
            title: Text('Twitter'),
            onTap: openTwitter,
          ),
          ListTile(
            onTap: openYoutube,
            leading: FaIcon(
              FontAwesomeIcons.youtube,
              color: TirajColors.iconInActive,
            ),
            title: Text('Youtube'),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.instagram,
              color: TirajColors.iconInActive,
            ),
            title: Text('Instagram'),
            onTap: openInstagram,
          ),
          ListTile(
            onTap: openTelegram,
            leading: FaIcon(
              FontAwesomeIcons.telegram,
              color: TirajColors.iconInActive,
            ),
            title: Text('Telegram'),
          ),
          ListTile(
            onTap: openWhatsApp,
            leading: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: TirajColors.iconInActive,
            ),
            title: Text('WhatsApp'),
          ),
          Divider(),
          ListTile(
            title: Text('Выйти'),
            leading: Icon(
              Icons.exit_to_app,
              color: TirajColors.iconInActive,
            ),
            onTap: exitApp,
          ),
        ],
      ),
    );
  }
}
