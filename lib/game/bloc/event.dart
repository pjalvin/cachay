part of 'bloc.dart';

abstract class GameEvent extends Equatable {}

class LoadGame extends GameEvent {
  final Game game;
  LoadGame(this.game);
  @override
  List<Object> get props => [game];
}
class AumentarTempo extends GameEvent{
  AumentarTempo();
  @override
  List<Object> get props => [];
}
class Lanzar1 extends GameEvent {
  String idSala;
  Lanzar1(this.idSala);
  @override
  List<Object> get props => [];
}
class Lanzar2 extends GameEvent {
  String idSala;
  Lanzar2(this.idSala);
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
class Paso0 extends GameEvent {
  Paso0();
  @override
  List<Object> get props => [];
}
class Paso1 extends GameEvent {
  Paso1();
  @override
  List<Object> get props => [];
}
class Intercambiar1 extends GameEvent {
  int i;
  Intercambiar1(this.i);
  @override
  List<Object> get props => [];
}
class Intercambiar2 extends GameEvent {
  int i;
  Intercambiar2(this.i);
  @override
  List<Object> get props => [];
}
class VolteoIni extends GameEvent{
  int i;
  VolteoIni(this.i);

  @override
  List<Object> get props =>  [];

}
class VoltearDados extends GameEvent {
  int i;
  VoltearDados(this.i);
  @override
  List<Object> get props => [];
}
class CambiarCombo extends GameEvent {
  String i;
  CambiarCombo(this.i);
  @override
  List<Object> get props => [];
}
class DeterminarGrupo extends GameEvent {
  int i;
  DeterminarGrupo(this.i);
  @override
  List<Object> get props => [];
}
class ActualizarPuntua extends GameEvent {
  var i;
  ActualizarPuntua(this.i);
  @override
  List<Object> get props => [];
}
class IniciarDeNuevo extends GameEvent {
  IniciarDeNuevo();
  @override
  List<Object> get props => [];
}
class CargandoAct extends GameEvent {
  CargandoAct();
  @override
  List<Object> get props => [];
}
class CargandoDesac extends GameEvent {
  CargandoDesac();
  @override
  List<Object> get props => [];
}
class Turno extends GameEvent {
  int turno;
  Turno(this.turno);
  @override
  List<Object> get props => [];
}
class CambiarJugada1 extends GameEvent{
  List<dynamic> jugada;
  int i;
  CambiarJugada1(this.jugada,this.i);
  @override
  List<Object> get props => [];
}
class CambiarJugada2 extends GameEvent{
  List<dynamic> jugada;
  int i;
  CambiarJugada2(this.jugada,this.i);
  @override
  List<Object> get props => [];
}
class SubirPaso4 extends GameEvent{
  String idSala;
  SubirPaso4(this.idSala);
  @override
  List<Object> get props => [];
}