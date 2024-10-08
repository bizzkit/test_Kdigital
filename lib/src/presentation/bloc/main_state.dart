import 'package:kdigital_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {}

class InitialMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class UnSuccessfulMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class SuccessfulMainPageState extends MainPageState {
  final List<Character> characters;

  SuccessfulMainPageState(this.characters);

  @override
  List<Object> get props => [characters];
}

class LoadingImageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class UnSuccessfulImageLoadState extends MainPageState {
  @override
  List<Object> get props => [];
}

class ImageLoadedState extends MainPageState {
  final String imageUrl;

  ImageLoadedState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

