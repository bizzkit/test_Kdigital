import 'package:kdigital_test/src/data/models/character.dart';
import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:kdigital_test/src/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kdigital_test/src/presentation/ui/character_detail_screen.dart';
import 'package:kdigital_test/src/presentation/ui/loading_screen.dart';

class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Characters', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {
          if (state is UnSuccessfulImageLoadState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading image')),
            );
          }
        },
        builder: (blocContext, state) {
          if (state is LoadingMainPageState) {
            return LoadingScreen();
          } else if (state is SuccessfulMainPageState) {
            return _successfulWidget(context, state);
          } else {
            return Center(child: const Text("Error loading characters"));
          }
        },
      ),
    );
  }

  Widget _successfulWidget(
      BuildContext context, SuccessfulMainPageState state) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<MainPageBloc>(context)
            .add(LoadingDataOnMainPageEvent());

        await Future.delayed(Duration(seconds: 1));

        BlocProvider.of<MainPageBloc>(context)
            .add(GetTestDataOnMainPageEvent(1));
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent) {
            BlocProvider.of<MainPageBloc>(context)
                .add(LoadMoreCharactersEvent());
          }
          return false;
        },
        child: ListView.builder(
          itemCount: state.characters.length,
          itemBuilder: (context, index) {
            return _characterWidget(context, state.characters[index]);
          },
        ),
      ),
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(_createRoute(character));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      character.species,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute(Character character) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return CharacterDetailScreen(character: character);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
