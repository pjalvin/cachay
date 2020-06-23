part of 'bloc.dart';

abstract class GameEvent extends Equatable {}

class LoadGame extends GameEvent {
  final Game game;
  LoadGame(this.game);
  @override
  List<Object> get props => [game];
}
class Lanzar1 extends GameEvent {
  Lanzar1();
  @override
  List<Object> get props => [];
}
class Lanzar2 extends GameEvent {
  Lanzar2();
  @override
  List<Object> get props => [];
}
class Pasar3 extends GameEvent {
  Pasar3();
  @override
  List<Object> get props => [];
}
class SubirPaso extends GameEvent {
  SubirPaso();
  @override
  List<Object> get props => [];
}
class Ayuda extends GameEvent {
  Ayuda();
  @override
  List<Object> get props => [];
}
class IniciarJugada extends GameEvent {
  Size size;
  int tipo;
  IniciarJugada(this.size,this.tipo);
  @override
  List<Object> get props => [];
}
class AnotarJugada extends GameEvent {
  AnotarJugada();
  @override
  List<Object> get props => [];
}
class ConseguirJugada extends GameEvent {
  ConseguirJugada();
  @override
  List<Object> get props => [];
}