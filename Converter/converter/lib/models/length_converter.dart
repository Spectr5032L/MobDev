class LengthConverter {
  static double convert(String from, String to, double value) {
    if (from == 'м') {
      if (to == 'см') {
        return value * 100;
      } else if (to == 'км') {
        return value / 1000;
      } else if (to == 'миля') {
        return value / 1609.34;
      } else if (to == 'морская миля') {
        return value / 1852;
      }
    } else if (from == 'см') {
      if (to == 'м') {
        return value / 100;
      } else if (to == 'км') {
        return value / 100000;
      } else if (to == 'миля') {
        return value / 160934;
      } else if (to == 'морская миля') {
        return value / 185200;
      }
    } else if (from == 'км') {
      if (to == 'м') {
        return value * 1000;
      } else if (to == 'см') {
        return value * 100000;
      } else if (to == 'миля') {
        return value / 1.60934;
      } else if (to == 'морская миля') {
        return value / 1.852;
      }
    } else if (from == 'миля') {
      if (to == 'м') {
        return value * 1609.34;
      } else if (to == 'см') {
        return value * 160934;
      } else if (to == 'км') {
        return value * 1.60934;
      } else if (to == 'морская миля') {
        return value / 1.151;
      }
    } else if (from == 'морская миля') {
      if (to == 'м') {
        return value * 1852;
      } else if (to == 'см') {
        return value * 185200;
      } else if (to == 'км') {
        return value * 1.852;
      } else if (to == 'миля') {
        return value * 1.151;
      }
    }
    return value;
  }
}