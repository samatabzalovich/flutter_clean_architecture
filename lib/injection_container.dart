import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repository/article_repo.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepo>(
    ArticleRepositoryImpl(sl(),sl())
  );
  
  //UseCases
  sl.registerSingleton<GetAricleUseCase>(
    GetAricleUseCase(sl())
  );

  sl.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl())
  );
  
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl())
  );


  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(sl())
  );

  sl.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(sl(),sl(),sl())
  );

}
