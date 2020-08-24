import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

/*
音乐播放模块
 */

class MusicPlayer{
  String _localPath='';  // 音乐地址
  static AudioPlayer _audioPlayer = AudioPlayer(); //播放器
  static AudioCache _player = AudioCache(prefix: 'audio/');

  MusicPlayer(this._localPath);

  play() async {
//    int result = await _audioPlayer.play(localPath, isLocal: true);
    if(!_localPath.contains("mp3"))return;
    if(_audioPlayer.state == AudioPlayerState.PLAYING){
      stop();
      _audioPlayer = await _player.loop(_localPath);
    }
    else{
      _audioPlayer = await _player.loop(_localPath);
    }
  }

  stop()async{
    await _audioPlayer.stop();
  }

  changeMusic(String musicUrl){
    stop();
    _localPath = musicUrl;
    play();
  }

//  pause()async{
//    int result = await _audioPlayer.pause();
//  }

//  // 播放进度 position
//  Duration   position = Duration();
//  getPosition(){
//    _audioPlayer.onAudioPositionChanged.listen((Duration  p){
//      print('Current position: $p');
//          setState(() => position = p);
//      });
//  }
//



}

