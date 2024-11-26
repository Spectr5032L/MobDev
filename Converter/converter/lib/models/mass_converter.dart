class MassConverter {
  static double convert(String from, String to, double value) {
    if (from == 'кг') {
      if (to == 'г') {
        return value * 1000;
      } else if (to == 'карат') {
        return value * 5000;
      }
    } else if (from == 'г') {
      if (to == 'кг') {
        return value / 1000;
      } else if (to == 'карат') {
        return value * 5;
      }
    } else if (from == 'карат') {
      if (to == 'кг') {
        return value / 5000;
      } else if (to == 'г') {
        return value / 5;
      }
    }
    return value;
  }
}