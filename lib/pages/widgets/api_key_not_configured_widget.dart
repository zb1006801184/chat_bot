import 'package:flutter/material.dart';

/// API Key 未配置提示组件
///
/// 当 Gemini API Key 未配置时显示的提示界面
/// 包含配置步骤说明和操作指引
class ApiKeyNotConfiguredWidget extends StatelessWidget {
  const ApiKeyNotConfiguredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 智能助手'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.api, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 24),
              Text(
                'API Key 未配置',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '请先配置 Gemini API Key 才能使用聊天功能',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '配置步骤:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildStepItem('1. 访问 https://ai.google.dev/'),
                      _buildStepItem('2. 登录 Google 账号'),
                      _buildStepItem('3. 创建新的 API Key'),
                      _buildStepItem(
                        '4. 在 lib/config/api_config.dart 中替换 API Key',
                      ),
                      _buildStepItem('5. 重启应用'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建步骤项
  Widget _buildStepItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
