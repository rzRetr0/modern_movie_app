import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';


class MovieDetailsPage extends StatefulWidget {
  final int id;
  final String type; // 'movie' or 'tv'

  const MovieDetailsPage({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  dynamic _selectedSeason;
  dynamic _movieDetails;
  dynamic _tvDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('[DEBUG] MovieDetailsPage: widget.id = ' + widget.id.toString() + ', widget.type = ' + widget.type.toString());
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 'tv') {
      context.read<MovieBloc>().add(GetTvDetailsEvent(widget.id));
    } else {
      context.read<MovieBloc>().add(GetMovieDetailsEvent(widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          // Store the details when loaded
          if (state is MovieDetailsLoaded) {
            _movieDetails = state.movieDetails;
          } else if (state is TvDetailsLoaded) {
            _tvDetails = state.tvDetails;
          }

          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          Widget _buildMovieDetails(movie) {
            print('[DEBUG] _buildMovieDetails: movie.id = ' + (movie.id?.toString() ?? 'null'));
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: movie.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Container(color: Colors.grey),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? 'No Title',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              movie.voteAverage?.toStringAsFixed(1) ?? '-',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 16),
                            Text('(${movie.voteCount ?? 0} votes)'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          movie.overview ?? 'No overview available.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _launchTrailer,
                              icon: const Icon(Icons.ondemand_video),
                              label: const Text('Watch Trailer'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: _launchWatch,
                              icon: const Icon(Icons.play_circle_fill),
                              label: const Text('Watch'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildInfoCard('Release Date', movie.releaseDate ?? '-', Icons.event),
                            _buildInfoCard('Language', movie.originalLanguage?.toUpperCase() ?? '-', Icons.language),
                            _buildInfoCard('Popularity', movie.popularity?.toStringAsFixed(1) ?? '-', Icons.trending_up),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          Widget _buildTvDetails(tv) {
            print('[DEBUG] _buildTvDetails: tv.id = ' + (tv.id?.toString() ?? 'null'));
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: tv.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : Container(color: Colors.grey),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tv.name ?? 'No Name',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              tv.voteAverage?.toStringAsFixed(1) ?? '-',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 16),
                            Text('(${tv.voteCount ?? 0} votes)'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tv.overview ?? 'No overview available.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildInfoCard('First Air Date', tv.firstAirDate ?? '-', Icons.event),
                            _buildInfoCard('Language', tv.originalLanguage?.toUpperCase() ?? '-', Icons.language),
                            _buildInfoCard('Popularity', tv.popularity?.toStringAsFixed(1) ?? '-', Icons.trending_up),
                          ],
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                if (tv.seasons != null && tv.seasons.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seasons', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Select Season:', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<dynamic>(
                                    value: _selectedSeason,
                                    hint: const Text('Choose a season'),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    items: tv.seasons?.map<DropdownMenuItem<dynamic>>((season) {
                                      return DropdownMenuItem<dynamic>(
                                        value: season,
                                        child: Text(season.name ?? 'Season ${season.seasonNumber}'),
                                      );
                                    }).toList() ?? [],
                                    onChanged: (season) {
                                      if (season != null) {
                                        setState(() {
                                          _selectedSeason = season;
                                        });
                                        print('[DEBUG] Selected season: ${season.name ?? 'Season ${season.seasonNumber}'}');
                                        if (season.episodes == null || season.episodes.isEmpty) {
                                          print('[DEBUG] Dispatching LoadSeasonEpisodesEvent for tvId=' + tv.id.toString() + ', seasonNumber=' + season.seasonNumber.toString());
                                          context.read<MovieBloc>().add(LoadSeasonEpisodesEvent(tvId: tv.id, seasonNumber: season.seasonNumber));
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Episodes section - only show if a season is selected
                  if (_selectedSeason != null) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Episodes',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: BlocBuilder<MovieBloc, MovieState>(
                        builder: (context, state) {
                          final isLoading = state is SeasonEpisodesLoading && state.seasonNumber == _selectedSeason.seasonNumber;
                          final loaded = state is SeasonEpisodesLoaded && state.seasonNumber == _selectedSeason.seasonNumber;
                          final loadedSeason = loaded ? (state as SeasonEpisodesLoaded).season : _selectedSeason;

                          if (isLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (loadedSeason.episodes != null && loadedSeason.episodes.isNotEmpty) {
                            return Column(
                              children: loadedSeason.episodes.map<Widget>((ep) {
                                print('[UI DEBUG] Episode: name=' + (ep.name ?? 'null').toString() + ', episodeNumber=' + (ep.episodeNumber?.toString() ?? 'null'));
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  child: ListTile(
                                    leading: ep.stillPath != null
                                        ? CachedNetworkImage(
                                            imageUrl: 'https://image.tmdb.org/t/p/w200${ep.stillPath}',
                                            width: 80,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(width: 80, height: 60, color: Colors.grey),
                                    title: Text(ep.name ?? 'Episode ${ep.episodeNumber}'),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Episode ${ep.episodeNumber}'),
                                        if (ep.airDate != null) Text('Aired: ${ep.airDate}'),
                                      ],
                                    ),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        final tvIdForUrl = (tv.imdbId != null && tv.imdbId.isNotEmpty) ? tv.imdbId : tv.id.toString();
                                        final url = _buildEmbedUrl(
                                          type: 'tv',
                                          id: tvIdForUrl,
                                          season: loadedSeason.seasonNumber.toString(),
                                          episode: ep.episodeNumber.toString(),
                                        );
                                        final title = '${tv.name ?? 'TV Show'} - S${loadedSeason.seasonNumber}E${ep.episodeNumber}';
                                        print('[DEBUG] Navigating to video player with URL: ' + url);
                                        context.go('/video-player?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(title)}');
                                      },
                                      child: const Text('Watch'),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            print('[DEBUG] No episode data for seasonNumber=${loadedSeason.seasonNumber}');
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No episode data available for this season.'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ],
            );
          }

          if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.type == 'tv') {
                        context.read<MovieBloc>().add(GetTvDetailsEvent(widget.id));
                      } else {
                        context.read<MovieBloc>().add(GetMovieDetailsEvent(widget.id));
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is MovieDetailsLoaded) {
            return _buildMovieDetails(state.movieDetails);
          } else if (_movieDetails != null) {
            return _buildMovieDetails(_movieDetails);
          }

          if (state is TvDetailsLoaded) {
            return _buildTvDetails(state.tvDetails);
          } else if (_tvDetails != null) {
            return _buildTvDetails(_tvDetails);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _launchTrailer() async {
    final url = 'https://www.youtube.com/results?search_query=${Uri.encodeComponent((context.read<MovieBloc>().state as MovieDetailsLoaded).movieDetails.title ?? '')}+trailer';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch trailer link.')),
      );
    }
  }

  void _launchWatch() async {
    final movie = (context.read<MovieBloc>().state as MovieDetailsLoaded).movieDetails;
    final id = (movie.imdbId?.isNotEmpty ?? false) ? movie.imdbId : movie.id?.toString();
    print('[DEBUG] _launchWatch: movie.id = ' + (id ?? 'null'));
    if (id == null || id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movie ID is missing. Cannot launch link.')),
      );
      return;
    }
    final url = _buildEmbedUrl(type: 'movie', id: id);
    final title = movie.title ?? 'Movie';
    print('Navigating to video player with URL: $url');
    context.go('/video-player?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(title)}');
  }

  /// Builds the correct embed URL for vidsrc.cc
  /// type: 'movie', 'tv', 'anime'
  /// id: movie/tv/anime id
  /// season, episode, animeType: optional for tv/anime
  String _buildEmbedUrl({
    required String type,
    required String id,
    String? season,
    String? episode,
    String? animeType,
  }) {
    if (type == 'movie') {
      return 'https://vidsrc.cc/v2/embed/movie/$id';
    } else if (type == 'tv') {
      if (season != null && episode != null) {
        return 'https://vidsrc.cc/v2/embed/tv/$id/$season/$episode';
      } else if (season != null) {
        return 'https://vidsrc.cc/v2/embed/tv/$id/$season';
      } else {
        return 'https://vidsrc.cc/v2/embed/tv/$id';
      }
    } else if (type == 'anime') {
      // v2 for anime
      return 'https://vidsrc.cc/v2/embed/anime/$id/${episode ?? ''}/${animeType ?? ''}';
    }
    // fallback
    return 'https://vidsrc.cc/';
  }
}

