export default class VideoMatchupApi {
  static async fetchMatchups(videoID) {
    return await fetch(`/api/videos/${videoID}/matchups`);
  }

  static async newMatchup(videoID, sec, chara1ID, chara2ID) {
    return await $.ajax({
      type: 'post',
      url: `/api/videos/${videoID}/matchups`,
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content,
        sec: sec,
        chara1_id: chara1ID,
        chara2_id: chara2ID
      }
    });
  }

  static async deleteMatchup(matchupID) {
    return await $.ajax({
      type: 'delete',
      url: `/api/video_matchups/${matchupID}`,
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content
      }
    })
  }
}
