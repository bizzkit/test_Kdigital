import 'package:kdigital_test/src/data/models/character.dart';
import 'package:kdigital_test/src/data/repository/characters_repository.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;
  int _currentPage = 1;
  bool _isLastPage = false;
  List<Character> _characters = [];

  MainPageBloc(this._charactersRepository) : super(InitialMainPageState()) {
    on<GetTestDataOnMainPageEvent>(_getDataOnMainPage);
    on<DataLoadedOnMainPageEvent>(_dataLoadedOnMainPage);
    on<LoadingDataOnMainPageEvent>(_loadingData);
    on<LoadImageEvent>(_loadImage);
    on<LoadMoreCharactersEvent>(_loadMoreCharacters);
    on<LoadCharactersEvent>(_loadCharacters);
  }

  CharactersRepository get charactersRepository => _charactersRepository;

  Future<void> _getDataOnMainPage(
      GetTestDataOnMainPageEvent event, Emitter<MainPageState> emit) async {
    emit(LoadingMainPageState());
    _currentPage = 1;
    try {
      final characters =
          await _charactersRepository.getCharacters(_currentPage);
      if (characters != null && characters.isNotEmpty) {
        _characters = characters;
        _currentPage++;
        emit(SuccessfulMainPageState(_characters));
      } else {
        emit(UnSuccessfulMainPageState());
      }
    } catch (error) {
      emit(UnSuccessfulMainPageState());
    }
  }

  Future<void> _loadMoreCharacters(
      LoadMoreCharactersEvent event, Emitter<MainPageState> emit) async {
    if (_isLastPage) return;

    try {
      final newCharacters =
          await _charactersRepository.getCharacters(_currentPage);
      if (newCharacters != null && newCharacters.isNotEmpty) {
        _characters.addAll(newCharacters);
        _currentPage++;
        emit(SuccessfulMainPageState(_characters));
      } else {
        _isLastPage = true;
      }
    } catch (error) {
      emit(UnSuccessfulMainPageState());
    }
  }

  Future<void> _loadCharacters(
      LoadCharactersEvent event, Emitter<MainPageState> emit) async {
    emit(LoadingMainPageState());
    _currentPage = 1;
    _isLastPage = false;
    try {
      final characters =
          await _charactersRepository.getCharacters(_currentPage);
      if (characters != null && characters.isNotEmpty) {
        _characters = characters;
        _currentPage++;
        emit(SuccessfulMainPageState(_characters));
      } else {
        emit(UnSuccessfulMainPageState());
      }
    } catch (error) {
      emit(UnSuccessfulMainPageState());
    }
  }

  Future<void> _dataLoadedOnMainPage(
      DataLoadedOnMainPageEvent event, Emitter<MainPageState> emit) async {}

  Future<void> _loadingData(
      LoadingDataOnMainPageEvent event, Emitter<MainPageState> emit) async {
    emit(LoadingMainPageState());
  }

  Future<void> _loadImage(
      LoadImageEvent event, Emitter<MainPageState> emit) async {
    emit(LoadingImageState());
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(ImageLoadedState(event.imageUrl));
    } catch (error) {
      emit(UnSuccessfulImageLoadState());
      print("Error loading image: $error");
    }
  }
}
