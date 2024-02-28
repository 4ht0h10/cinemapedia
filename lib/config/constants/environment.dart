
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {


  static String movieDBKey = dotenv.env['THE_MOVIEDB_KEY']?? 'ERROR: missing variable THE_MOVIEDB_KEY';
  static String bearerToken = dotenv.env['THEMOVIEDB_BEARER_TOKEN']?? 'ERROR: missing variable THEMOVIEDB_BEARER_TOKEN';
  
}