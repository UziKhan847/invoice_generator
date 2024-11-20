enum CostFrequency {
  hourly('hr'),
  daily('day'),
  weekly('wk'),
  monthly('mo'),
  yearly('yr');

  const CostFrequency(this.frequency);

  final String frequency;

}