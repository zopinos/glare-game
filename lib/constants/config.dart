const double desktopGameWidth = 800.0;
const double desktopGameHeight = 600.0;
const double mobileGameWidth = 600.0;
const double mobileGameHeight = 800.0;

const double ballSize = 10.0;
const double boardWidth = 25.0;
const double gravity = 0.0;
const double hittableMaxSpeed = 20.0;
const double playerAngularDamping = 5.0;
const double hittableSize = 2.0;
const double enemySize = 2.0;
const double spawnOffset = 5.0;
const double playerMoveFactor = 1.0;
const double scoreIndicatorLifeTime = 1.0;

const List<double> spawnFrequencies = [0.5, 0.5, 0.5];

const List<String> entityTypes = ["hittable", "enemy"];

const List<int> scoreRequirements = [20, 20, 20];

const List<double> spawnRates = [1.0, 0.75, 0.5];

const bool debug = false;
