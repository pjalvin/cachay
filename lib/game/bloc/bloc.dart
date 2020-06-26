import 'package:cachay/game/componentes/Tablero2/Lanzador.dart';
import 'package:cachay/game/funciones_cloud/Funcion.dart';
import 'package:cachay/game/funciones_cloud/Movimientos.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/game/repository/game_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  GameBloc(this.gameRepository);

  @override
  GameState get initialState => GameInit();

  @override
  Stream<GameState> mapEventToState(GameEvent event)async*{
    
    if(event is IniciarJugada){
      try{
        final game= gameRepository.getGame(event.size,event.tipo);
        print(game.TamTableros);
        yield GameLoaded(game: game);
      }
      catch(err){
        print(err);
      }
    }
    else if(event is Paso0){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.paso0();
      yield GameLoaded(game: game);

    }
    else if(event is Paso1){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.paso1();
      yield GameLoaded(game: game);

    }
    else if(event is Ayuda){
      final game=gameRepository.ayuda();
      yield GameLoaded(game: game);

    }
    else if(event is SubirPaso){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.aumentarPaso();
      yield GameLoaded(game: game);

    }
    else if(event is Turno){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.turno(event.turno);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is CargandoAct){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.cargandoAct();
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is CargandoDesac){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.cargandoDesac();
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is ActualizarPuntua){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.actualizarPuntuacion(event.i);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is IniciarDeNuevo){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.iniciarJugada();
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is Lanzar1)
    {
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        await gameRepository.lanzarDados1();
        final game=gameRepository.aumentarPaso();
        await Movimientos().SubirMovi(event.idSala, convertirArray(game.dados), convertirArray(game.dadosRetenidos));
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is Lanzar2)
    {
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      await gameRepository.lanzarDados2();
      gameRepository.moverDadospaso3();
      final game=gameRepository.aumentarPaso();
      await Movimientos().SubirMovi(event.idSala, convertirArray(game.dados), convertirArray(game.dadosRetenidos));
      yield GameLoaded(game: game);
    }
    else if(event is Pasar3)
    {
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        gameRepository.moverDadospaso3();
        final game=gameRepository.aumentarPaso();
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is Intercambiar1){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.intercambiarDados1(event.i);
      yield GameLoaded(game: game);
    }
    else if(event is SubirPaso4){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.subirPaso4();
      await Movimientos().SubirMovi(event.idSala, convertirArray(game.dados), convertirArray(game.dadosRetenidos));
      yield GameLoaded(game: game);

    }
    else if(event is Intercambiar2){
      final gameLoading=gameRepository.obtenerGame();
      yield GameLoading(game:gameLoading);
      final game=gameRepository.intercambiarDados2(event.i);
      yield GameLoaded(game: game);
    }
    else if(event is VoltearDados){
      try{

        final gamevol1=gameRepository.volteoIni(event.i);
        yield GameLoading2(game:gamevol1);
        print("evento${event.i}");
        final game=await gameRepository.volteoDados(event.i);
        print(game.dados);
        yield GameLoaded(game: game);
        print("si envia");
      }
      catch(e){
        print(e);
      }
    }
    else if(event is CambiarCombo){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.cambiarCombo(event.i);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is DeterminarGrupo){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.agruparDadosAnotar(event.i);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }
    else if(event is CambiarJugada1){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.cambiarJugada1(event.jugada, event.i);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }

    else if(event is CambiarJugada2){
      try{
        final gameLoading=gameRepository.obtenerGame();
        yield GameLoading(game:gameLoading);
        final game=gameRepository.cambiarJugada2(event.jugada, event.i);
        yield GameLoaded(game: game);
      }
      catch(e){
        print(e);
      }
    }


  }
  List<int> convertirArray(List array){
    List<int> aux=List();
    for(var item in array){
      aux.add(item[0]);
      print(item);
    }
    return aux;
  }

}