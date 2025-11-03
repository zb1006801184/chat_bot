import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// 自定义 Gemini Provider，适配 flutter_ai_toolkit
class GeminiProvider extends LlmProvider {
  final GenerativeModel _model;
  final List<ChatMessage> _history = [];
  final List<VoidCallback> _listeners = [];
  ChatSession? _chatSession; // 添加聊天会话管理

  GeminiProvider({required GenerativeModel model}) : _model = model {
    // 初始化聊天会话
    _chatSession = _model.startChat();
  }


  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    try {
      // 使用聊天会话发送消息，保持上下文
      final response = await _chatSession!.sendMessage(Content.text(prompt));

      if (response.text != null) {
        yield response.text!;
      }
    } catch (e) {
      yield '错误: ${e.toString()}';
    }
  }

//发送消息
  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    try {
      // 添加用户消息到历史记录
      final userMessage = ChatMessage.user(prompt, attachments);
      _history.add(userMessage);
      _notifyListeners();

      // 创建 AI 消息
      final aiMessage = ChatMessage.llm();
      _history.add(aiMessage);
      _notifyListeners();

      // 使用聊天会话发送消息，保持上下文记忆
      final response = await _chatSession!.sendMessage(Content.text(prompt));

      if (response.text != null) {
        aiMessage.text = response.text!;
        _notifyListeners();
        yield response.text!;
      }
    } catch (e) {
      final errorMessage = '错误: ${e.toString()}';
      final aiMessage = _history.last;
      aiMessage.text = errorMessage;
      _notifyListeners();
      yield errorMessage;
    }
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
    _history.clear();
    _history.addAll(history);
    _notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  /// 通知监听器
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// 清除聊天历史记录并重新开始会话
  void clearHistory() {
    _history.clear();
    _chatSession = _model.startChat(); // 重新开始聊天会话
    _notifyListeners();
  }

  /// 获取当前聊天会话的历史消息数量
  int get historyLength => _history.length;

  /// 检查是否有聊天历史
  bool get hasHistory => _history.isNotEmpty;
}
