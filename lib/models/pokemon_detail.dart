class PokemonDetail {
  final String id;
  final String image;
  final String localId;
  final String name;
  final String rarity;
  final int hp;
  final String description;
  final String stage;

  PokemonDetail({
    required this.id,
    required this.image,
    required this.localId,
    required this.name,
    required this.rarity,
    required this.hp,
    required this.description,
    required this.stage,
  });

  String get imageHigh => '$image/high.png';
  String get imageLow => '$image/low.png';

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      localId: json['localId'] ?? '',
      name: json['name'] ?? '',
      rarity: json['rarity'] ?? 'Unknown',
      hp: int.tryParse(json['hp']?.toString() ?? '0') ?? 0,
      description: json['description'] ?? 'No description available.',
      stage: json['stage'] ?? 'Basic',
    );
  }
}
