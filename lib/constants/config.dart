import 'package:flame/extensions.dart';

const double desktopGameWidth = 800.0;
const double desktopGameHeight = 600.0;
const double mobileGameWidth = 600.0;
const double mobileGameHeight = 800.0;

const int totalLevels = 3;
const double playerSize = 2.5;
const double playerBounciness = 0.75;
const double gravity = 0.0;
const double hittableMaxSpeed = 20.0;
const double playerAngularDamping = 5.0;
const double hittableSize = 2.0;
const double enemySize = 2.0;
const double spawnOffset = 5.0;
const double playerMoveFactor = 1.0;
const double scoreIndicatorLifeTime = 1.0;
const double minImpulseForce = 200.0;
const double maxImpulseForce = 8000.0;
const double scoreIndicatorTextSize = 2.0;
const double gameTimeLength = 30.0;

// Colors
const Color hittableColor = Color.fromARGB(255, 255, 226, 64);
const Color enemyColor = Color.fromARGB(255, 255, 64, 64);
const Color gameBackgroundColor = Color.fromARGB(255, 20, 20, 20);

const List<double> spawnFrequencies = [0.5, 0.5, 0.5];

const List<String> entityTypes = ["hittable", "enemy"];

const List<int> scoreRequirements = [20, 20, 20];

const List<double> spawnRates = [1.0, 0.75, 0.5];

const bool debug = false;
