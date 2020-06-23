part of 'bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}
class GameInit extends GameState{

  const GameInit();

  @override
  List<Object> get props => [];
}
class GameLoading extends GameState{

  const GameLoading();

  @override
  List<Object> get props => [];
}
class GameLoaded extends GameState {
  final Game game;

  const GameLoaded({@required this.game});

  @override
  List<Object> get props => [game];

  @override
  String toString() => '$runtimeType { $game }';
}
