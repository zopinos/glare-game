const double gameWidth = 800.0;
const double gameHeight = 600.0;
const double ballSize = 10.0;
const double boardWidth = 25.0;
const double gravity = 0.0;
const double hittableMaxSpeed = 20.0;
const double playerAngularDamping = 5.0;
const double hittableSize = 2.0;
const double enemySize = 2.0;
const double spawnOffset = 5.0;
const double playerMoveFactor = 1.0;

const List<double> spawnFrequencies = [0.5, 0.5, 0.5];

const Map<int, List<String>> levelEntityTypes = {
  0: ["hittable"],
  1: ["hittable", "enemy"],
  2: ["hittable", "enemy"],
};
