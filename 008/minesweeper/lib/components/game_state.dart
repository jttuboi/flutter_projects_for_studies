enum GameState {
  WON,
  RUNNING,
  ENDED,
}

extension GameStateExtension on GameState {
  bool isRunning() {
    return this == GameState.RUNNING;
  }
}
