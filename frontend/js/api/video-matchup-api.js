export default class VideoMatchupApi {
  static async fetchMatchups(videoID) {
    return fetch(`/api/videos/${videoID}/matchups`);
  }

  static async newMatchup(videoID, sec, chara1ID, chara2ID) {
    return $.ajax({
      type: 'post',
      url: `/api/videos/${videoID}/matchups`,
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content,
        sec,
        chara1_id: chara1ID,
        chara2_id: chara2ID,
      },
    });
  }

  static async deleteMatchup(matchupID) {
    return $.ajax({
      type: 'delete',
      url: `/api/video_matchups/${matchupID}`,
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content,
      },
    });
  }
}
