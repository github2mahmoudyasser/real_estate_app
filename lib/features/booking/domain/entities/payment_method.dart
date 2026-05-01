enum PaymentMethod {
  fullPayment('Full Payment', 'Pay the total amount at once'),
  partialPayment('Partial Payment', 'Pay 30% now, rest later'),
  card('Card', 'Pay with credit/debit card'),
  bankTransfer('Bank Transfer', 'Direct bank transfer'),
  mobileBanking('Mobile Banking', 'Use mobile banking app');

  final String label;
  final String description;

  const PaymentMethod(this.label, this.description);
}