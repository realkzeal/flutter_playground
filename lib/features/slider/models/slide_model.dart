class SlideModel {
  final String id;
  final String imageUrl;
  final String title;
  final String description;

  SlideModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'SlideModel{id: $id, imageUrl: $imageUrl, title: $title, description: $description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SlideModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^ imageUrl.hashCode ^ title.hashCode ^ description.hashCode;
}
