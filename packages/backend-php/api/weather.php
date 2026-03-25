<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// 模拟城市数据
$cities = [
    '北京' => ['lat' => 39.9042, 'lon' => 116.4074, 'name' => '北京'],
    '上海' => ['lat' => 31.2304, 'lon' => 121.4737, 'name' => '上海'],
    '广州' => ['lat' => 23.1291, 'lon' => 113.2644, 'name' => '广州'],
    '深圳' => ['lat' => 22.5431, 'lon' => 114.0579, 'name' => '深圳'],
    '杭州' => ['lat' => 30.2741, 'lon' => 120.1551, 'name' => '杭州'],
    '成都' => ['lat' => 30.5728, 'lon' => 104.0668, 'name' => '成都'],
];

// 获取请求的城市
$cityName = isset($_GET['city']) ? trim($_GET['city']) : '北京';

// 如果城市不存在，默认北京
if (!isset($cities[$cityName])) {
    $cityName = '北京';
}

$city = $cities[$cityName];

// 模拟天气数据 - 随机生成
$baseTemp = date('m') >= 12 || date('m') <= 2 ? 10 : 25;
$temperature = $baseTemp + rand(-5, 5) + (rand() / getrandmax()) * 3;
$temperature = round($temperature, 1);

$response = [
    'success' => true,
    'data' => [
        'city' => [
            'name' => $city['name'],
            'lat' => $city['lat'],
            'lon' => $city['lon'],
        ],
        'weather' => [
            'temperature' => $temperature,
            'feelsLike' => $temperature - 1.5,
            'minTemp' => $temperature - 3,
            'maxTemp' => $temperature + 3,
            'humidity' => rand(40, 80),
            'windSpeed' => round(rand(10, 50) / 10, 1),
            'pressure' => 1013 + rand(-10, 10),
            'description' => getRandomDescription(),
            'icon' => getRandomIcon(),
            'timestamp' => time(),
        ],
        'hourly' => generateHourlyForecast($temperature),
    ],
    'metadata' => [
        'generated_at' => date('c'),
        'generator' => 'PHP Backend API - Shit Mountain Project',
    ]
];

echo json_encode($response, JSON_PRETTY_PRINT);
exit;

function getRandomDescription() {
    $descriptions = ['晴朗', '多云', '阴天', '小雨', '大风', '雾'];
    return $descriptions[array_rand($descriptions)];
}

function getRandomIcon() {
    $icons = ['01d', '02d', '03d', '04d', '10d', '50d'];
    return $icons[array_rand($icons)];
}

function generateHourlyForecast($baseTemp) {
    $hourly = [];
    $now = time();
    for ($i = 0; $i < 24; $i++) {
        $hourly[] = [
            'time' => date('c', $now + $i * 3600),
            'temperature' => round($baseTemp + sin(($i / 24) * M_PI * 2) * 5, 1),
            'icon' => $i < 6 || $i > 18 ? '01n' : '01d',
        ];
    }
    return $hourly;
}
?>
