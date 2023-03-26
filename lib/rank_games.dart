class Ranks {
  int? rank;
  int? appid;
  int? lastWeekRank;
  int? peakInGame;

  Ranks({
    this.rank,
    this.appid,
    this.lastWeekRank,
    this.peakInGame
  });

  Ranks.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    appid = json['appid'];
    lastWeekRank = json['last_week_rank'];
    peakInGame = json['peak_in_game'];
  }


}