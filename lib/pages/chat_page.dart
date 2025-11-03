import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_config.dart';
import '../providers/gemini_provider.dart';
import 'widgets/api_key_not_configured_widget.dart';

/// AI 聊天界面页面
///
/// 使用 flutter_ai_toolkit 提供的 LlmChatView 实现聊天功能
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late GeminiProvider _provider;

  @override
  void initState() {
    super.initState();
    // 初始化 provider
    _provider = GeminiProvider(
      model: GenerativeModel(
        model: ApiConfig.geminiModel,
        apiKey: ApiConfig.geminiApiKey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 检查 API Key 是否已配置
    if (!ApiConfig.isApiKeyConfigured) {
      return const ApiKeyNotConfiguredWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 智能助手'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        centerTitle: true,
        actions: [
          // 添加清除历史记录按钮
          IconButton(
            icon: const Icon(Icons.clear_all),
            tooltip: '清除对话历史',
            onPressed: () {
              _showClearHistoryDialog(context);
            },
          ),
        ],
      ),
      body: LlmChatView(
        provider: _provider,
        suggestions: ['你好', '你是谁', '你是做什么的', '你是怎么工作的'],
      ),
    );
  }

  /// 显示清除历史记录确认对话框
  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('清除对话历史'),
          content: const Text('确定要清除所有对话历史记录吗？此操作无法撤销。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                _provider.clearHistory(); // 清除历史记录
                Navigator.of(context).pop(); // 关闭对话框
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('对话历史已清除'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}
