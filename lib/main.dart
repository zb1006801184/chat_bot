import 'package:flutter/material.dart';
import 'pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AI Toolkit 演示',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 使用现代化的主题配色
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        // 自定义应用栏主题
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
        // 自定义卡片主题
        cardTheme: const CardThemeData(elevation: 2),
        // 自定义输入框主题
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      home: const ChatPage(),
    );
  }
}
