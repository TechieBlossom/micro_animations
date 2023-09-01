final dataset = [
  Data("JAN", 1500, 1000, 800, 0),
  Data("FEB", 500, 800, 1000, 1000),
  Data("MAR", 1000, 2800, 700, 500),
  Data("APR", 1500, 2400, 300, 500),
  Data("MAY", 1200, 2000, 800, 400),
  Data("JUN", 2500, 500, 400, 600),
  Data("JUL", 1500, 1000, 600, 300),
  Data("AUG", 500, 2000, 300, 300),
];

class Data {
  final String monthName;
  final double food;
  final double medical;
  final double travel;
  final double others;

  Data(
    this.monthName,
    this.food,
    this.medical,
    this.travel,
    this.others,
  );
}
