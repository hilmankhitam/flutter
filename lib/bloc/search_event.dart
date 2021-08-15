part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

}

class TextChanged extends SearchEvent{
  final String text;

  const TextChanged({required this.text});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Text Changed { text: $text }';
}