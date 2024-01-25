import 'package:logger/logger.dart';

class Institution {
  List<String> countryCodes, dtcNumbers, products, routingNumbers;
  bool oauth;
  String institutionId, name;

  Institution(
      {this.countryCodes = const [],
      this.dtcNumbers = const [],
      this.oauth = false,
      this.institutionId = '',
      this.name = '',
      this.products = const [],
      this.routingNumbers = const []});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      countryCodes: json['country_codes'] == null
          ? []
          : List<String>.from(json['country_codes'].map((x) => x)).toList(),
      dtcNumbers: json['dtc_numbers'] != null
          ? List<String>.from(json['dtc_numbers'].map((x) => x)).toList()
          : [],
      oauth: json['oauth'] ?? false,
      institutionId: json['institution_id'] ?? '',
      name: json['name'] ?? '',
      products: json['products'] == null
          ? []
          : List<String>.from(json['products'].map((x) => x)).toList(),
      routingNumbers: ['routing_numbers'] == null
          ? []
          : List<String>.from(json['routing_numbers'].map((x) => x)).toList(),
    );
  }

  @override
  String toString() {
    return 'Institution{countryCodes: $countryCodes, dtcNumbers: $dtcNumbers, products: $products, routingNumbers: $routingNumbers, oauth: $oauth, institutionId: $institutionId, name: $name}';
  }
}
