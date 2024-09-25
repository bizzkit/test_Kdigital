import 'package:kdigital_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  final int page;

  const GetTestDataOnMainPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final List<Character>? characters;

  const DataLoadedOnMainPageEvent(this.characters);

  @override
  List<Object?> get props => [characters];
}

class LoadImageEvent extends MainPageEvent {
  final String imageUrl;

  const LoadImageEvent(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class LoadMoreCharactersEvent extends MainPageEvent {}

class LoadCharactersEvent extends MainPageEvent {}
