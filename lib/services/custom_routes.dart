import 'dart:convert';

import 'package:animix/config/enum.dart';
import 'package:animix/models/genra.dart';
import 'package:animix/screens/all_anime_screen.dart';
import 'package:animix/screens/detail.dart';
import 'package:animix/screens/home_page.dart';
import 'package:animix/screens/search_screen.dart';
import 'package:animix/screens/tab_sceen.dart';
import 'package:animix/screens/video_screen.dart';
import 'package:animix/screens/favourites_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    FirebaseAnalytics().logEvent(
        name: "screen_view", parameters: {"screen": "${settings.name},"});
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const TabScreen());
      case '/homescreen':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/searchscreen':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => const FavouritesScreen());
      case '/detailscreen':
        final arge = json.decode(settings.arguments.toString());
        final id = arge['id'];
        final type = arge['type'];
        return MaterialPageRoute(
          builder: (_) => AnimeDetail(
            id: id,
          ),
        );
      case '/allanimescreen':
        final arge = json.decode(settings.arguments.toString());
        print(arge);
        final gnera = Genra.fromJson(arge['gnera']);
        final query = arge['query'];
        return MaterialPageRoute(
          builder: (_) => AllAnimeScreen(
            gnera: gnera,
            query: query,
          ),
        );

      case '/videoscreen':
        final arge = json.decode(settings.arguments.toString());
        final videoUrl = arge['videoUrl'];
        final title = arge['title'];
        return MaterialPageRoute(
          builder: (_) => VideoScreen(
            title: title,
            videoUrl: videoUrl,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
