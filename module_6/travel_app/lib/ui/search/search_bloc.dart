import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/package.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class TriggerSearch extends SearchEvent {
  final String keyword;
  const TriggerSearch(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

///State
abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}

class SearchLoadSuccess extends SearchState {
  final List<Package> packages;
  const SearchLoadSuccess(this.packages);
  @override
  List<Object?> get props => [packages];
}

class SearchLoadFailed extends SearchState {}

///Bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TravelPackageRepository _travelPackageRepository;
  SearchBloc(this._travelPackageRepository) : super(SearchInitial()) {
    on<TriggerSearch>(_onTriggerSearch);
  }

  void _onTriggerSearch(TriggerSearch event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await _travelPackageRepository.searchPackages(event.keyword);
    emit(SearchLoadSuccess(result));
  }
}
