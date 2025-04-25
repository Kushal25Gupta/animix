import 'package:animix/models/anime.dart';
import 'package:animix/providers/episodeprovider.dart';
import 'package:animix/widgets/episode_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EpisodesList extends StatefulWidget {
  final Anime anime;

  const EpisodesList({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  @override
  void initState() {
    final episodeProvider = Provider.of<EpisodeProvider>(
      context,
      listen: false,
    );
    episodeProvider.fetchEpisodes(
      widget.anime.malId!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EpisodeProvider>(
      builder: (_, episodeProvider, __) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: episodeProvider.episodes
              .map(
                (e) => EpisodeTile(
                  animeid: widget.anime.malId!,
                  episode: e,
                  image: widget.anime.images!.largeImageUrl!,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
