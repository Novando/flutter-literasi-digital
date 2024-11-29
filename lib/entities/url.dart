class UrlEntity {
  final List<String> videos;
  final List<String> images;

  UrlEntity(this.videos, this.images);

  UrlEntity.fromJson(Map json) :
    videos = json['videos'],
    images = json['images'];

  Map toJson() => {
    'videos': videos,
    'images': images,
  };
}