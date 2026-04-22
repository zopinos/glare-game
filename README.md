# Glare Game

A game made with Flutter, Flame Engine and Forge2D. This is the second project for the course [Device-Agnostic Design with Flutter and Dart](https://opencs.aalto.fi/en/courses/device-agnostic-design).

The game can be accessed on the web here: https://zopinos.github.io/glare-game/

The game includes a physics object controlled by the player. The object is controlled by swiping on the screen to the desired direction. The goal of the game is to reach the score indicated by the interface in 30 seconds by hitting the yellow moving objects. In later levels there are also red moving objects that disrupt the score gathering by decreasing the score if the player hits them. There are three levels in total with rising difficulty. The game tracks the progress of the player and saves the current progress with level completions and high scores.

The 3rd level is quite difficult and might even need some luck to be completed.

## Instructions

The start screen is used to start the game. The start screen leads to the level selection screen where you can select one of three levels. Two of the levels need to be made available by playing the level before.

By selecting a level you are brought to the game screen where the game starts right away. By swiping on the screen using some pointing device (e.g. computer mouse, finger) the player object is pushed towards the direction of the swipe. Hit the yellow objects to increase the score. Watch out for the red objects and dodge them to not lose points. The game ends after 30 seconds have passed after the start of the level. After gathering enough points indicated by the interface, you can either continue gathering points or try to keep the score as it is until the time ends.

After the time is up, you are brought to the results screen telling if the level was completed or not. The screen also indicates the score gathered and tells if a new personal high score was achieved by the player. The results screen leads back to the start screen where the game can be started again.

To locally run the project use these at the root

```
flutter pub get     # install dependencies
```

```
flutter run         # start the app
```
