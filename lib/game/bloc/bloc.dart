import 'package:cachay/game/componentes/lanzador.dart';
import 'package:cachay/game/models/Game.dart';
import 'package:cachay/game/repository/game_repository.dart';
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
  // TODO: implement initialState
  GameState get initialState => GameInit();

  @override
  Stream<GameState> mapEventToState(GameEvent event)async*{
    yield GameLoading();
    // TODO: implement mapEventToState
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
    else if(event is SubirPaso){
      final game=gameRepository.aumentarPaso();
      yield GameLoaded(game: game);

    }
    else if(event is Lanzar1)
    {
       await gameRepository.lanzarDados1();
      final game=gameRepository.aumentarPaso();
      yield GameLoaded(game: game);
    }
    else if(event is Lanzar2)
    {
      await gameRepository.lanzarDados2();
      gameRepository.moverDadospaso3();
      final game=gameRepository.aumentarPaso();
      yield GameLoaded(game: game);
    }
    else if(event is Pasar3)
    {
      final game=gameRepository.moverDadospaso3();
      yield GameLoaded(game: game);
    }
  }

}