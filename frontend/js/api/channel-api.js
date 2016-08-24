export default class ChannelApi {
  async fetchChannelList() {
    return await fetch('/api/channels')
  }

  async fetchLatestMessages(channelID) {
    return await fetch(`/api/channels/${channelID}/messages`);
  }
}
