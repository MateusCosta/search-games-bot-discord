import 'package:dotenv/dotenv.dart';

class Env {
  static final _env = DotEnv();

  /// Carrega o arquivo .env com suporte a múltiplos ambientes
  static void load() {
    const environment =
        String.fromEnvironment('APP_ENV', defaultValue: 'development');
    final envFile =
        environment == 'production' ? '.env.production' : '.env.development';

    try {
      _env.load([envFile]);
      print('Arquivo $envFile carregado.');
    } catch (e) {
      print('Erro ao carregar o arquivo .env: $e');
    }
  }

  static String get(String key, {String? defaultValue, bool required = false}) {
    final value = _env[key] ?? defaultValue;
    if (required && (value == null || value.isEmpty)) {
      throw Exception('Variável de ambiente "$key" não definida.');
    }
    return value!;
  }
}
