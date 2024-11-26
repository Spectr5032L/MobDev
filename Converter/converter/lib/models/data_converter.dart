class DataConverter {
  static const Map<String, double> _dataUnits = {
    'Байт': 1.0,
    'КБ': 1024.0,
    'МБ': 1024.0 * 1024.0,
    'ГБ': 1024.0 * 1024.0 * 1024.0,
    'ТБ': 1024.0 * 1024.0 * 1024.0 * 1024.0,
  };

  static double convert(String from, String to, double value) {
    double fromUnit = _dataUnits[from]!;
    double toUnit = _dataUnits[to]!;
    return value * fromUnit / toUnit;
  }
}
