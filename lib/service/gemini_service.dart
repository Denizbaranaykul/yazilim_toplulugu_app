import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late GenerativeModel _model;
  bool _initialized = false;

  // Topluluk bilgisi
  final String communityInfo = '''
- Topluluğun adı: Yazılım Geliştirme Topluluğu
- Toplantılar: Her çarşamba 18:00, A-101 sınıfı
- Başkan: Atakan Çelik
- Başkan Yardımcısı: Deniz Baran Aykul
- Katılım: Ücretsiz
''';

  // Başlatma fonksiyonu (Remote Config üzerinden API key alma)
  Future<void> init() async {
    if (_initialized) return;

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      // Remote Config'i fetch ve activate et
      await remoteConfig.fetchAndActivate();

      final apiKey = remoteConfig.getString('GEMINI_API_KEY');
      if (apiKey.isEmpty) {
        throw Exception("API key Remote Config'ten alınamadı.");
      }

      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      _initialized = true;
    } catch (e) {
      throw Exception("API key yüklenemedi: $e");
    }
  }

  // Mesaj gönderme
  Future<String> getResponse(String userMessage) async {
    await init();

    try {
      final response = await _model.generateContent([
        Content.text('Topluluk bilgisi:\n$communityInfo\n\nSoru: $userMessage'),
      ]);

      return response.text ?? 'Cevap alınamadı';
    } catch (e) {
      return 'Cevap alınamadı: $e';
    }
  }
}
