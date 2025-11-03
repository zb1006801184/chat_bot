// API 配置文件
//
// 使用说明:
// 1. 访问 https://ai.google.dev/ 获取 Gemini API Key
// 2. 将下面的 'YOUR_GEMINI_API_KEY' 替换为你的实际 API Key
// 3. 请勿将真实的 API Key 提交到代码仓库中

class ApiConfig {
  /// Gemini API Key
  ///
  /// 获取方式:
  /// 1. 访问 https://ai.google.dev/
  /// 2. 登录 Google 账号
  /// 3. 创建新的 API Key
  /// 4. 复制 API Key 并替换下面的占位符
  static const String geminiApiKey = 'AIzaSyDqdiwzk-xuxCmYi2dFHkJk34o1iHyl-IA';

  /// Gemini 模型名称
  /// 可选模型: gemini-2.0-flash, gemini-1.5-pro, gemini-1.5-flash
  static const String geminiModel = 'gemini-2.0-flash';

  /// 检查 API Key 是否已配置
  static bool get isApiKeyConfigured => geminiApiKey.isNotEmpty;
}
