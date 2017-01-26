export default class ChannelApi {
  static async fetchChannelList() {
    return fetch('/api/channels');
  }

  static async fetchLatestMessages(channelID) {
    return fetch(`/api/channels/${channelID}/messages`);
  }

  static async newSummary(title, description, channelID, messageIDs) {
    return $.ajax({
      type: 'post',
      url: '/summaries.json',
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content,
        title,
        description,
        slack_channel: channelID,
        slack_messages: messageIDs,
      },
    });
  }

  static async editSummary(summaryID, title, description, channelID, messageIDs) {
    return $.ajax({
      type: 'put',
      url: `/summaries/${summaryID}.json`,
      data: {
        authenticity_token: document.querySelector('meta[name="csrf-token"]').content,
        title,
        description,
        slack_channel: channelID,
        slack_messages: messageIDs,
      },
    });
  }
}
