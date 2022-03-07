double celciusFahrenheit(double cel) {
  return (1.8 * cel) + 32;
}

double fahrenheitCelcius(double fah) {
  return (fah - 32) / 1.8;
}

double celciusReamur(double cel) {
  return (4 / 5) * cel;
}

double reamurCelcius(double rea) {
  return (5 / 4) * rea;
}

double celciusKelvin(double cel) {
  return (cel + 273);
}

double kelCelcius(double kel) {
  return kel - 273;
}

double reamurFahrenheit(double rea) {
  return (9 / 4 * rea) + 32;
}

double fahreRea(double fah) {
  return (4 / 9) * (fah - 32);
}

void main() {
  print(celciusFahrenheit(30));
  print(fahrenheitCelcius(200));
  print(celciusReamur(20));
  print(reamurCelcius(30));
  print(celciusKelvin(50));
  print(kelCelcius(90));
  print(reamurFahrenheit(20));
  print(fahreRea(70));
}
