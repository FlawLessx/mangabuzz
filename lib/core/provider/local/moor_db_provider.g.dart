// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db_provider.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String title;
  final String mangaEndpoint;
  final String image;
  final String author;
  final String type;
  final String rating;
  final String description;
  Bookmark(
      {@required this.title,
      @required this.mangaEndpoint,
      @required this.image,
      this.author,
      this.type,
      this.rating,
      this.description});
  factory Bookmark.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Bookmark(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      mangaEndpoint: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}manga_endpoint']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      rating:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || mangaEndpoint != null) {
      map['manga_endpoint'] = Variable<String>(mangaEndpoint);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<String>(rating);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      mangaEndpoint: mangaEndpoint == null && nullToAbsent
          ? const Value.absent()
          : Value(mangaEndpoint),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Bookmark(
      title: serializer.fromJson<String>(json['title']),
      mangaEndpoint: serializer.fromJson<String>(json['mangaEndpoint']),
      image: serializer.fromJson<String>(json['image']),
      author: serializer.fromJson<String>(json['author']),
      type: serializer.fromJson<String>(json['type']),
      rating: serializer.fromJson<String>(json['rating']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'mangaEndpoint': serializer.toJson<String>(mangaEndpoint),
      'image': serializer.toJson<String>(image),
      'author': serializer.toJson<String>(author),
      'type': serializer.toJson<String>(type),
      'rating': serializer.toJson<String>(rating),
      'description': serializer.toJson<String>(description),
    };
  }

  Bookmark copyWith(
          {String title,
          String mangaEndpoint,
          String image,
          String author,
          String type,
          String rating,
          String description}) =>
      Bookmark(
        title: title ?? this.title,
        mangaEndpoint: mangaEndpoint ?? this.mangaEndpoint,
        image: image ?? this.image,
        author: author ?? this.author,
        type: type ?? this.type,
        rating: rating ?? this.rating,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('title: $title, ')
          ..write('mangaEndpoint: $mangaEndpoint, ')
          ..write('image: $image, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('rating: $rating, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      title.hashCode,
      $mrjc(
          mangaEndpoint.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  author.hashCode,
                  $mrjc(type.hashCode,
                      $mrjc(rating.hashCode, description.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.title == this.title &&
          other.mangaEndpoint == this.mangaEndpoint &&
          other.image == this.image &&
          other.author == this.author &&
          other.type == this.type &&
          other.rating == this.rating &&
          other.description == this.description);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> title;
  final Value<String> mangaEndpoint;
  final Value<String> image;
  final Value<String> author;
  final Value<String> type;
  final Value<String> rating;
  final Value<String> description;
  const BookmarksCompanion({
    this.title = const Value.absent(),
    this.mangaEndpoint = const Value.absent(),
    this.image = const Value.absent(),
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.rating = const Value.absent(),
    this.description = const Value.absent(),
  });
  BookmarksCompanion.insert({
    @required String title,
    @required String mangaEndpoint,
    @required String image,
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.rating = const Value.absent(),
    this.description = const Value.absent(),
  })  : title = Value(title),
        mangaEndpoint = Value(mangaEndpoint),
        image = Value(image);
  static Insertable<Bookmark> custom({
    Expression<String> title,
    Expression<String> mangaEndpoint,
    Expression<String> image,
    Expression<String> author,
    Expression<String> type,
    Expression<String> rating,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (mangaEndpoint != null) 'manga_endpoint': mangaEndpoint,
      if (image != null) 'image': image,
      if (author != null) 'author': author,
      if (type != null) 'type': type,
      if (rating != null) 'rating': rating,
      if (description != null) 'description': description,
    });
  }

  BookmarksCompanion copyWith(
      {Value<String> title,
      Value<String> mangaEndpoint,
      Value<String> image,
      Value<String> author,
      Value<String> type,
      Value<String> rating,
      Value<String> description}) {
    return BookmarksCompanion(
      title: title ?? this.title,
      mangaEndpoint: mangaEndpoint ?? this.mangaEndpoint,
      image: image ?? this.image,
      author: author ?? this.author,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mangaEndpoint.present) {
      map['manga_endpoint'] = Variable<String>(mangaEndpoint.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('title: $title, ')
          ..write('mangaEndpoint: $mangaEndpoint, ')
          ..write('image: $image, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('rating: $rating, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  final GeneratedDatabase _db;
  final String _alias;
  $BookmarksTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mangaEndpointMeta =
      const VerificationMeta('mangaEndpoint');
  GeneratedTextColumn _mangaEndpoint;
  @override
  GeneratedTextColumn get mangaEndpoint =>
      _mangaEndpoint ??= _constructMangaEndpoint();
  GeneratedTextColumn _constructMangaEndpoint() {
    return GeneratedTextColumn(
      'manga_endpoint',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedTextColumn _rating;
  @override
  GeneratedTextColumn get rating => _rating ??= _constructRating();
  GeneratedTextColumn _constructRating() {
    return GeneratedTextColumn(
      'rating',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [title, mangaEndpoint, image, author, type, rating, description];
  @override
  $BookmarksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'bookmarks';
  @override
  final String actualTableName = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('manga_endpoint')) {
      context.handle(
          _mangaEndpointMeta,
          mangaEndpoint.isAcceptableOrUnknown(
              data['manga_endpoint'], _mangaEndpointMeta));
    } else if (isInserting) {
      context.missing(_mangaEndpointMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  Bookmark map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Bookmark.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(_db, alias);
  }
}

class History extends DataClass implements Insertable<History> {
  final String title;
  final String mangaEndpoint;
  final String image;
  final String author;
  final String type;
  final String rating;
  final int chapterReached;
  final int totalChapter;
  History(
      {@required this.title,
      @required this.mangaEndpoint,
      @required this.image,
      this.author,
      this.type,
      this.rating,
      this.chapterReached,
      this.totalChapter});
  factory History.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return History(
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      mangaEndpoint: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}manga_endpoint']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      rating:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      chapterReached: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}chapter_reached']),
      totalChapter: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_chapter']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || mangaEndpoint != null) {
      map['manga_endpoint'] = Variable<String>(mangaEndpoint);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<String>(rating);
    }
    if (!nullToAbsent || chapterReached != null) {
      map['chapter_reached'] = Variable<int>(chapterReached);
    }
    if (!nullToAbsent || totalChapter != null) {
      map['total_chapter'] = Variable<int>(totalChapter);
    }
    return map;
  }

  HistorysCompanion toCompanion(bool nullToAbsent) {
    return HistorysCompanion(
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      mangaEndpoint: mangaEndpoint == null && nullToAbsent
          ? const Value.absent()
          : Value(mangaEndpoint),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      chapterReached: chapterReached == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterReached),
      totalChapter: totalChapter == null && nullToAbsent
          ? const Value.absent()
          : Value(totalChapter),
    );
  }

  factory History.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return History(
      title: serializer.fromJson<String>(json['title']),
      mangaEndpoint: serializer.fromJson<String>(json['mangaEndpoint']),
      image: serializer.fromJson<String>(json['image']),
      author: serializer.fromJson<String>(json['author']),
      type: serializer.fromJson<String>(json['type']),
      rating: serializer.fromJson<String>(json['rating']),
      chapterReached: serializer.fromJson<int>(json['chapterReached']),
      totalChapter: serializer.fromJson<int>(json['totalChapter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'mangaEndpoint': serializer.toJson<String>(mangaEndpoint),
      'image': serializer.toJson<String>(image),
      'author': serializer.toJson<String>(author),
      'type': serializer.toJson<String>(type),
      'rating': serializer.toJson<String>(rating),
      'chapterReached': serializer.toJson<int>(chapterReached),
      'totalChapter': serializer.toJson<int>(totalChapter),
    };
  }

  History copyWith(
          {String title,
          String mangaEndpoint,
          String image,
          String author,
          String type,
          String rating,
          int chapterReached,
          int totalChapter}) =>
      History(
        title: title ?? this.title,
        mangaEndpoint: mangaEndpoint ?? this.mangaEndpoint,
        image: image ?? this.image,
        author: author ?? this.author,
        type: type ?? this.type,
        rating: rating ?? this.rating,
        chapterReached: chapterReached ?? this.chapterReached,
        totalChapter: totalChapter ?? this.totalChapter,
      );
  @override
  String toString() {
    return (StringBuffer('History(')
          ..write('title: $title, ')
          ..write('mangaEndpoint: $mangaEndpoint, ')
          ..write('image: $image, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('rating: $rating, ')
          ..write('chapterReached: $chapterReached, ')
          ..write('totalChapter: $totalChapter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      title.hashCode,
      $mrjc(
          mangaEndpoint.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  author.hashCode,
                  $mrjc(
                      type.hashCode,
                      $mrjc(
                          rating.hashCode,
                          $mrjc(chapterReached.hashCode,
                              totalChapter.hashCode))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is History &&
          other.title == this.title &&
          other.mangaEndpoint == this.mangaEndpoint &&
          other.image == this.image &&
          other.author == this.author &&
          other.type == this.type &&
          other.rating == this.rating &&
          other.chapterReached == this.chapterReached &&
          other.totalChapter == this.totalChapter);
}

class HistorysCompanion extends UpdateCompanion<History> {
  final Value<String> title;
  final Value<String> mangaEndpoint;
  final Value<String> image;
  final Value<String> author;
  final Value<String> type;
  final Value<String> rating;
  final Value<int> chapterReached;
  final Value<int> totalChapter;
  const HistorysCompanion({
    this.title = const Value.absent(),
    this.mangaEndpoint = const Value.absent(),
    this.image = const Value.absent(),
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.rating = const Value.absent(),
    this.chapterReached = const Value.absent(),
    this.totalChapter = const Value.absent(),
  });
  HistorysCompanion.insert({
    @required String title,
    @required String mangaEndpoint,
    @required String image,
    this.author = const Value.absent(),
    this.type = const Value.absent(),
    this.rating = const Value.absent(),
    this.chapterReached = const Value.absent(),
    this.totalChapter = const Value.absent(),
  })  : title = Value(title),
        mangaEndpoint = Value(mangaEndpoint),
        image = Value(image);
  static Insertable<History> custom({
    Expression<String> title,
    Expression<String> mangaEndpoint,
    Expression<String> image,
    Expression<String> author,
    Expression<String> type,
    Expression<String> rating,
    Expression<int> chapterReached,
    Expression<int> totalChapter,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (mangaEndpoint != null) 'manga_endpoint': mangaEndpoint,
      if (image != null) 'image': image,
      if (author != null) 'author': author,
      if (type != null) 'type': type,
      if (rating != null) 'rating': rating,
      if (chapterReached != null) 'chapter_reached': chapterReached,
      if (totalChapter != null) 'total_chapter': totalChapter,
    });
  }

  HistorysCompanion copyWith(
      {Value<String> title,
      Value<String> mangaEndpoint,
      Value<String> image,
      Value<String> author,
      Value<String> type,
      Value<String> rating,
      Value<int> chapterReached,
      Value<int> totalChapter}) {
    return HistorysCompanion(
      title: title ?? this.title,
      mangaEndpoint: mangaEndpoint ?? this.mangaEndpoint,
      image: image ?? this.image,
      author: author ?? this.author,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      chapterReached: chapterReached ?? this.chapterReached,
      totalChapter: totalChapter ?? this.totalChapter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mangaEndpoint.present) {
      map['manga_endpoint'] = Variable<String>(mangaEndpoint.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (chapterReached.present) {
      map['chapter_reached'] = Variable<int>(chapterReached.value);
    }
    if (totalChapter.present) {
      map['total_chapter'] = Variable<int>(totalChapter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorysCompanion(')
          ..write('title: $title, ')
          ..write('mangaEndpoint: $mangaEndpoint, ')
          ..write('image: $image, ')
          ..write('author: $author, ')
          ..write('type: $type, ')
          ..write('rating: $rating, ')
          ..write('chapterReached: $chapterReached, ')
          ..write('totalChapter: $totalChapter')
          ..write(')'))
        .toString();
  }
}

class $HistorysTable extends Historys with TableInfo<$HistorysTable, History> {
  final GeneratedDatabase _db;
  final String _alias;
  $HistorysTable(this._db, [this._alias]);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _mangaEndpointMeta =
      const VerificationMeta('mangaEndpoint');
  GeneratedTextColumn _mangaEndpoint;
  @override
  GeneratedTextColumn get mangaEndpoint =>
      _mangaEndpoint ??= _constructMangaEndpoint();
  GeneratedTextColumn _constructMangaEndpoint() {
    return GeneratedTextColumn(
      'manga_endpoint',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      true,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedTextColumn _rating;
  @override
  GeneratedTextColumn get rating => _rating ??= _constructRating();
  GeneratedTextColumn _constructRating() {
    return GeneratedTextColumn(
      'rating',
      $tableName,
      true,
    );
  }

  final VerificationMeta _chapterReachedMeta =
      const VerificationMeta('chapterReached');
  GeneratedIntColumn _chapterReached;
  @override
  GeneratedIntColumn get chapterReached =>
      _chapterReached ??= _constructChapterReached();
  GeneratedIntColumn _constructChapterReached() {
    return GeneratedIntColumn(
      'chapter_reached',
      $tableName,
      true,
    );
  }

  final VerificationMeta _totalChapterMeta =
      const VerificationMeta('totalChapter');
  GeneratedIntColumn _totalChapter;
  @override
  GeneratedIntColumn get totalChapter =>
      _totalChapter ??= _constructTotalChapter();
  GeneratedIntColumn _constructTotalChapter() {
    return GeneratedIntColumn(
      'total_chapter',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        title,
        mangaEndpoint,
        image,
        author,
        type,
        rating,
        chapterReached,
        totalChapter
      ];
  @override
  $HistorysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'historys';
  @override
  final String actualTableName = 'historys';
  @override
  VerificationContext validateIntegrity(Insertable<History> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('manga_endpoint')) {
      context.handle(
          _mangaEndpointMeta,
          mangaEndpoint.isAcceptableOrUnknown(
              data['manga_endpoint'], _mangaEndpointMeta));
    } else if (isInserting) {
      context.missing(_mangaEndpointMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author'], _authorMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    }
    if (data.containsKey('chapter_reached')) {
      context.handle(
          _chapterReachedMeta,
          chapterReached.isAcceptableOrUnknown(
              data['chapter_reached'], _chapterReachedMeta));
    }
    if (data.containsKey('total_chapter')) {
      context.handle(
          _totalChapterMeta,
          totalChapter.isAcceptableOrUnknown(
              data['total_chapter'], _totalChapterMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  History map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return History.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HistorysTable createAlias(String alias) {
    return $HistorysTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $BookmarksTable _bookmarks;
  $BookmarksTable get bookmarks => _bookmarks ??= $BookmarksTable(this);
  $HistorysTable _historys;
  $HistorysTable get historys => _historys ??= $HistorysTable(this);
  BookmarkDao _bookmarkDao;
  BookmarkDao get bookmarkDao =>
      _bookmarkDao ??= BookmarkDao(this as MyDatabase);
  HistoryDao _historyDao;
  HistoryDao get historyDao => _historyDao ??= HistoryDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bookmarks, historys];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$BookmarkDaoMixin on DatabaseAccessor<MyDatabase> {
  $BookmarksTable get bookmarks => attachedDatabase.bookmarks;
}
mixin _$HistoryDaoMixin on DatabaseAccessor<MyDatabase> {
  $HistorysTable get historys => attachedDatabase.historys;
}
