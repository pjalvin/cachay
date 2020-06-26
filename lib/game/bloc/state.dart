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
  final Game game;

  const GameLoading({@required this.game});

  @override
  List<Object> get props => [game];
}
class GameLoadingCrono extends GameState{
  final Game game;

  const GameLoadingCrono ({@required this.game});

  @override
  List<Object> get props => [game];
}
class GameLoading2 extends GameState{
  final Game game;

  const GameLoading2({@required this.game});

  @override
  List<Object> get props => [game];
}
class GameLoaded extends GameState {
  final Game game;

  const GameLoaded({@required this.game});

  @override
  List<Object> get props => [game];

  @override
  String toString() => '$runtimeType { $game }';
}
