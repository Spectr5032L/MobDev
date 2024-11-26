class TemperatureConverter {
  static double convert(String from, String to, double value) {
    if (from == 'Цельсий') {
      if (to == 'Фаренгейт') {
        return value * 1.8 + 32;
      } else if (to == 'Кельвин') {
        return value + 273.15;
      }
    } else if (from == 'Фаренгейт') {
      if (to == 'Цельсий') {
        return (value - 32) * 5 / 9;
      } else if (to == 'Кельвин') {
        return (value - 32) * 5 / 9 + 273.15;
      }
    } else if (from == 'Кельвин') {
      if (to == 'Цельсий') {
        return value - 273.15;
      } else if (to == 'Фаренгейт') {
        return (value - 273.15) * 9 / 5 + 32;
      }
    }
    return value;  // если нет преобразования
  }
}
