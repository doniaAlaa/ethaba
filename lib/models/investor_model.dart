class Investor {
  final String name;
  final double amount;
  final String comment;

  Investor({
    required this.name,
    required this.amount,
    required this.comment,
  });

  factory Investor.fromJson(Map<String, dynamic> json) {
    return Investor(
      name: json['name'],
      amount: json['amount'].toDouble(),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'comment': comment,
    };
  }
}
