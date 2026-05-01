enum InsuranceType {
  basic('Basic', 'Basic coverage', 25),
  standard('Standard', 'Standard coverage', 50),
  premium('Premium', 'Premium coverage', 100),
  bargain('Bargain', 'Budget-friendly option', 15),
  smart('Smart', 'Smart value package', 35);

  final String label;
  final String description;
  final double price;

  const InsuranceType(this.label, this.description, this.price);
}