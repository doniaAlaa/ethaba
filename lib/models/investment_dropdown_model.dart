class InvestmentDropdownItem {
  final int id;
  final String name;

  InvestmentDropdownItem({
    required this.id,
    required this.name,
  });

  factory InvestmentDropdownItem.fromJson(Map<String, dynamic> json) {
    return InvestmentDropdownItem(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class InvestmentDropdownResponse {
  final bool success;
  final List<InvestmentDropdownItem> data;

  InvestmentDropdownResponse({
    required this.success,
    required this.data,
  });

  factory InvestmentDropdownResponse.fromJson(Map<String, dynamic> json) {
    return InvestmentDropdownResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((i) => InvestmentDropdownItem.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}
