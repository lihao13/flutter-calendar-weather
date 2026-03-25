import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getWeatherIcon(String iconCode) {
  switch (iconCode.substring(0, 2)) {
    case '01': return FontAwesomeIcons.sun;
    case '02': return FontAwesomeIcons.cloudSun;
    case '03': return FontAwesomeIcons.cloud;
    case '04': return FontAwesomeIcons.clouds;
    case '09': return FontAwesomeIcons.cloudRain;
    case '10': return FontAwesomeIcons.cloudSunRain;
    case '11': return FontAwesomeIcons.cloudBolt;
    case '13': return FontAwesomeIcons.snowflake;
    case '50': return FontAwesomeIcons.fog;
    default: return FontAwesomeIcons.sun;
  }
}

String getWeatherDescription(String iconCode) {
  switch (iconCode.substring(0, 2)) {
    case '01': return '晴朗';
    case '02': return '多云';
    case '03': return '阴天';
    case '04': return '阴';
    case '09': return '小雨';
    case '10': return '中雨';
    case '11': return '雷阵雨';
    case '13': return '下雪';
    case '50': return '雾';
    default: return '未知';
  }
}
