// To parse this JSON data, do
//
//     final imageSearchModel = imageSearchModelFromJson(jsonString);

import 'dart:convert';

ImageSearchModel imageSearchModelFromJson(String str) => ImageSearchModel.fromJson(json.decode(str));

String imageSearchModelToJson(ImageSearchModel data) => json.encode(data.toJson());

class ImageSearchModel {
  Query query;
  String possibleRelatedSearch;
  ReverseImageResults reverseImageResults;
  Pagination pagination;

  ImageSearchModel({
    required this.query,
    required this.possibleRelatedSearch,
    required this.reverseImageResults,
    required this.pagination,
  });

  factory ImageSearchModel.fromJson(Map<String, dynamic> json) => ImageSearchModel(
    query: Query.fromJson(json["query"]),
    possibleRelatedSearch: json["possible_related_search"] ?? "",
    reverseImageResults: ReverseImageResults.fromJson(json["reverse_image_results"]),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "query": query.toJson(),
    "possible_related_search": possibleRelatedSearch,
    "reverse_image_results": reverseImageResults.toJson(),
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  dynamic currentPage;
  dynamic nextPage;
  dynamic previousPage;
  List<dynamic> pages;

  Pagination({
    this.currentPage,
    this.nextPage,
    this.previousPage,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    nextPage: json["next_page"],
    previousPage: json["previous_page"],
    pages: List<dynamic>.from(json["pages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "next_page": nextPage,
    "previous_page": previousPage,
    "pages": List<dynamic>.from(pages.map((x) => x)),
  };
}

class Query {
  String q;
  String imageUrl;
  String url;

  Query({
    required this.q,
    required this.imageUrl,
    required this.url,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    q: json["q"],
    imageUrl: json["image_url"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "image_url": imageUrl,
    "url": url,
  };
}

class ReverseImageResults {
  List<Organic> organic;
  List<SimilarImage> similarImages;
  List<Organic> pagesWithMatchingImages;

  ReverseImageResults({
    required this.organic,
    required this.similarImages,
    required this.pagesWithMatchingImages,
  });

  factory ReverseImageResults.fromJson(Map<String, dynamic> json) => ReverseImageResults(
    organic: List<Organic>.from(json["organic"].map((x) => Organic.fromJson(x))),
    similarImages: List<SimilarImage>.from(json["similar_images"].map((x) => SimilarImage.fromJson(x))),
    pagesWithMatchingImages: List<Organic>.from(json["pages_with_matching_images"].map((x) => Organic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "organic": List<dynamic>.from(organic.map((x) => x.toJson())),
    "similar_images": List<dynamic>.from(similarImages.map((x) => x.toJson())),
    "pages_with_matching_images": List<dynamic>.from(pagesWithMatchingImages.map((x) => x.toJson())),
  };
}

class Organic {
  String title;
  String url;
  String destination;
  String description;
  bool isAmp;
  String? dimensions;

  Organic({
    required this.title,
    required this.url,
    required this.destination,
    required this.description,
    required this.isAmp,
    this.dimensions,
  });

  factory Organic.fromJson(Map<String, dynamic> json) => Organic(
    title: json["title"],
    url: json["url"],
    destination: json["destination"],
    description: json["description"],
    isAmp: json["isAmp"],
    dimensions: json["dimensions"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "destination": destination,
    "description": description,
    "isAmp": isAmp,
    "dimensions": dimensions,
  };
}

class SimilarImage {
  String url;
  String thumbnail;

  SimilarImage({
    required this.url,
    required this.thumbnail,
  });

  factory SimilarImage.fromJson(Map<String, dynamic> json) => SimilarImage(
    url: json["url"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "thumbnail": thumbnail,
  };
}
