import 'package:json_annotation/json_annotation.dart';

part 'article_models.g.dart';

/// 顶层响应：对应 { "data": {...}, "errorCode": 0, "errorMsg": "" }
@JsonSerializable()
class ArticleListResponse {
  final ArticlePage? data;
  final int? errorCode;
  final String? errorMsg;

  ArticleListResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  factory ArticleListResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleListResponseToJson(this);
}

/// 分页数据：对应 data 内部
@JsonSerializable()
class ArticlePage {
  final int? curPage;
  final List<Article>? datas;
  final int? offset;
  final bool? over;
  final int? pageCount;
  final int? size;
  final int? total;

  ArticlePage({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  factory ArticlePage.fromJson(Map<String, dynamic> json) =>
      _$ArticlePageFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlePageToJson(this);
}

/// 文章条目：对应 datas 列表中的每一项
@JsonSerializable()
class Article {
  final bool? adminAdd;
  final String? apkLink;
  final int? audit;
  final String? author;
  final bool? canEdit;
  final int? chapterId;
  final String? chapterName;
  final bool? collect;
  final int? courseId;
  final String? desc;
  final String? descMd;
  final String? envelopePic;
  final bool? fresh;
  final String? host;
  final int? id;
  final bool? isAdminAdd;
  final String? link;
  final String? niceDate;
  final String? niceShareDate;
  final String? origin;
  final String? prefix;
  final String? projectLink;
  final int? publishTime;
  final int? realSuperChapterId;
  final int? selfVisible;
  final int? shareDate;
  final String? shareUser;
  final int? superChapterId;
  final String? superChapterName;
  final List<ArticleTag>? tags;
  final String? title;
  final int? type;
  final int? userId;
  final int? visible;
  final int? zan;

  Article({
    this.adminAdd,
    this.apkLink,
    this.audit,
    this.author,
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh,
    this.host,
    this.id,
    this.isAdminAdd,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

/// 文章标签：实际接口一般为 [{ "name": "...", "url": "..." }]
@JsonSerializable()
class ArticleTag {
  final String? name;
  final String? url;

  ArticleTag({
    this.name,
    this.url,
  });

  factory ArticleTag.fromJson(Map<String, dynamic> json) =>
      _$ArticleTagFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleTagToJson(this);
}


