import 'package:flutter_test/flutter_test.dart';
import 'package:trending_movies/config/helpers/helper.dart';

void main() {
  group('splitOverView Tests', () {
    test('Texto mayor que el límite', () {
      // Datos de prueba
      const String text =
          "Este es un texto muy largo que supera los 30 caracteres de longitud";
      const int limit = 30;

      // Ejecutar el método
      final result = Helper.splitOverView(text: text, limit: limit);

      // Validaciones
      expect(result['isDivide'], true);
      expect(result['firstPart'], "Este es un texto muy largo que");
      expect(result['secondPart'], "supera los 30 caracteres de longitud");
    });

    test('Texto igual al límite', () {
      const String text = "Este texto tiene 30 caractere";
      const int limit = 30;

      final result = Helper.splitOverView(text: text, limit: limit);

      expect(result['isDivide'], false);
      expect(result['firstPart'], text);
    });

    test('Texto menor que el límite', () {
      const String text = "Texto corto";
      const int limit = 30;

      final result = Helper.splitOverView(text: text, limit: limit);

      expect(result['isDivide'], false);
      expect(result['firstPart'], text);
    });
  });
}
