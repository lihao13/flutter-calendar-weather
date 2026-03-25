# Flutter 日历天气应用

Flutter 3.x 开发的日历天气应用，支持日历查看、日期选择、天气查询和多城市管理。

## 项目概述

技术栈: **Flutter 3.x + Dart + Provider**

## 核心功能

- ✅ 日历组件显示和日期选择（使用 `table_calendar`）
- ✅ 当日天气信息展示（温度、湿度、风速、天气状况等）
- ✅ 城市选择和天气查询（支持搜索）
- ✅ 天气详情页面（包含 24 小时预报）
- ✅ 深色/浅色主题切换
- ✅ 本地主题偏好存储

## 项目结构

```
lib/
├── constants/
│   └── app_colors.dart        # 颜色常量
├── models/
│   └── weather.dart           # 数据模型
├── providers/
│   ├── calendar_provider.dart # 日历状态管理
│   ├── theme_provider.dart    # 主题状态管理
│   └── weather_provider.dart  # 天气状态管理
├── screens/
│   ├── city_selection_screen.dart  # 城市选择页
│   ├── home_screen.dart           # 主页面（日历+天气）
│   └── weather_detail_screen.dart # 天气详情页
├── services/
│   └── weather_service.dart    # 天气服务（支持 mock）
├── utils/
│   └── weather_utils.dart      # 工具函数
├── widgets/
│   ├── hourly_forecast_list.dart # 逐小时预报组件
│   └── weather_card.dart         # 天气卡片组件
├── app_theme.dart             # 主题配置
└── main.dart                  # 应用入口
```

## 已完成功能

### 1. 项目初始化 ✅
- [x] 创建 Flutter 项目结构
- [x] 配置 pubspec.yaml 依赖
- [x] 初始化基础项目配置

### 2. 核心组件开发 ✅
- [x] 日历组件: 使用 table_calendar 包实现
- [x] 天气 API 集成: 支持 OpenWeatherMap（当前使用 mock 数据演示）
- [x] 网络请求: 使用 dio
- [x] 状态管理: 使用 Provider

### 3. 页面设计 ✅
- [x] 主页面: 日历视图 + 天气卡片
- [x] 天气详情页: 详细天气信息 + 24 小时预报
- [x] 城市选择页: 支持搜索和选择城市

### 4. 数据管理 ✅
- [x] 本地存储主题偏好
- [x] 错误处理和加载状态
- [x] 支持 mock 数据演示

### 5. UI 优化 ✅
- [x] 响应式布局
- [x] 深色模式支持
- [x] 主题配置

### 6. 测试和发布
- [ ] 单元测试和 Widget 测试
- [ ] 性能优化
- [x] 支持 Docker 一键部署到服务器

## 技术选型理由

- **table_calendar**: 功能强大且稳定的日历组件
- **OpenWeatherMap**: 免费且可靠的天气 API
- **Provider**: 简单易用的状态管理方案
- **shared_preferences**: 轻量级本地存储
- **dio**: 强大的网络请求库

## 如何运行

### 本地开发
1. 确保你已经安装了 Flutter 3.x SDK
2. 克隆项目：
   ```bash
   git clone https://github.com/lihao13/flutter-calendar-weather.git
   cd flutter-calendar-weather
   ```
3. 获取依赖：
   ```bash
   flutter pub get
   ```
4. 运行项目：
   ```bash
   flutter run -d chrome  # Web 运行
   # 或者
   flutter run             # 选择设备运行
   ```

### Docker 部署到服务器（推荐）
已经配置好 Docker 一键部署，只要你的服务器有 Docker 和 Docker Compose，只需要三条命令：

```bash
git clone https://github.com/lihao13/flutter-calendar-weather.git
cd flutter-calendar-weather
docker-compose up -d --build
```

部署完成后，访问 `http://你的服务器IP` 即可使用。

## 免费服务器部署选项

如果你没有服务器，这里有几个免费选项：

| 平台 | 免费额度 | 是否支持 Docker |
|------|----------|----------------|
| **Fly.io** | 免费 3 个共享 CPU，256MB RAM，160GB 流量 | ✅ 支持 |
| **Render** | 免费静态站点 / 750 小时每月 | ✅ 支持 |
| **Railway** | 每月 $5 免费额度 | ✅ 支持 |
| **Oracle Cloud Free Tier** | 永久免费 1 核 1GB | ✅ 支持 |

选择任意一个，克隆代码后执行 `docker-compose up -d --build` 就完成了。

## GitHub Pages 在线预览（免费）

项目也配置了自动部署到 GitHub Pages：
https://lihao13.github.io/flutter-calendar-weather/

## 配置真实 OpenWeatherMap API

如果你想使用真实天气数据：

1. 在 [OpenWeatherMap](https://openweathermap.org/api) 注册并获取 API Key
2. 修改 `lib/services/weather_service.dart`，替换为真实 API 调用

## 许可证

MIT License
