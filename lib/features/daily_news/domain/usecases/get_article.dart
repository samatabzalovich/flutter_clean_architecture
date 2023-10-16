import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repo.dart';

class GetAricleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepo _articleRepositry;

  GetAricleUseCase(this._articleRepositry);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepositry.getNewArticles();
  }
}
