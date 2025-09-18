import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_carousel.dart';
import '../widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Load initial data
    context.read<MovieBloc>().add(const GetNowPlayingMoviesEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modern Movie App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.push('/favorites'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Now Playing'),
            Tab(text: 'Popular'),
            Tab(text: 'Top Rated'),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                context.read<MovieBloc>().add(const GetNowPlayingMoviesEvent());
                break;
              case 1:
                context.read<MovieBloc>().add(const GetPopularMoviesEvent());
                break;
              case 2:
                context.read<MovieBloc>().add(const GetTopRatedMoviesEvent());
                break;
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNowPlayingTab(),
          _buildPopularTab(),
          _buildTopRatedTab(),
        ],
      ),
    );
  }

  Widget _buildNowPlayingTab() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading && state is! MovieLoaded) {
          return const Center(child: CircularProgressIndicator());
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
                    context.read<MovieBloc>().add(const GetNowPlayingMoviesEvent());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        if (state is MovieLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MovieBloc>().add(const GetNowPlayingMoviesEvent());
            },
            child: CustomScrollView(
              slivers: [
                if (state.movies.isNotEmpty)
                  SliverToBoxAdapter(
                    child: MovieCarousel(movies: state.movies.take(5).toList()),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Now Playing Movies',
                      onSeeAll: () {
                        // Handle see all action
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.movies.length) {
                          return null;
                        }
                        return MovieCard(
                          movie: state.movies[index],
                          onTap: () {
                            context.push('/movie-details/${state.movies[index].id}');
                          },
                        );
                      },
                      childCount: state.movies.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPopularTab() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading && state is! MovieLoaded) {
          return const Center(child: CircularProgressIndicator());
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
                    context.read<MovieBloc>().add(const GetPopularMoviesEvent());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        if (state is MovieLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MovieBloc>().add(const GetPopularMoviesEvent());
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Popular Movies',
                      onSeeAll: () {
                        // Handle see all action
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.movies.length) {
                          return null;
                        }
                        return MovieCard(
                          movie: state.movies[index],
                          onTap: () {
                            context.push('/movie-details/${state.movies[index].id}');
                          },
                        );
                      },
                      childCount: state.movies.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTopRatedTab() {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading && state is! MovieLoaded) {
          return const Center(child: CircularProgressIndicator());
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
                    context.read<MovieBloc>().add(const GetTopRatedMoviesEvent());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        if (state is MovieLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MovieBloc>().add(const GetTopRatedMoviesEvent());
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Top Rated Movies',
                      onSeeAll: () {
                        // Handle see all action
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= state.movies.length) {
                          return null;
                        }
                        return MovieCard(
                          movie: state.movies[index],
                          onTap: () {
                            context.push('/movie-details/${state.movies[index].id}');
                          },
                        );
                      },
                      childCount: state.movies.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
