import ActionCable from "actioncable";

export
class Connector {
  messages = [];

  constructor() {
    if (!this.isRoom()) {
      return;
    }

    const cable = ActionCable.createConsumer();

    const connect = cable.subscriptions.create(`${roomName()}Channel`, {
      connected: function() {
        console.log('connected');
        this.fetchLatestMessages();
        this.fetchAvailableUsers();
      },

      disconnected: function() {
      },

      received: function(data) {
        console.log(data);
      },

      speak: function(message) {
        this.perform('speak', { message: message });
      }
    });
  }

  isRoom() {
    return document.querySelector('#room') ? true : false;
  }

  csrfToken() {
    return document.querySelector('meta[name="csrf-token"]').content;
  }

  screenName() {
    if (this.isRoom()) {
      return document.querySelector('#room').dataset.userScreenName;
    } else {
      return null;
    }
  }

  roomID() {
    if (this.isRoom()) {
      return document.querySelector('#room').dataset.roomId;
    } else {
      return null;
    }
  }

  roomName() {
    if (this.isRoom()) {
      return document.querySelector('#room').dataset.roomName;
    } else {
      return null;
    }
  }

  async fetchRoomList() {
    return await fetch('/api/rooms')
  }

  async fetchLatestMessages() {
    return await fetch(`/api/rooms/${this.roomID()}`);
  }

  async fetchUser() {
    return await fetch(`/api/user/${this.screenName()}`);
  }

  async newMessage() {
  }
}

export
const connector = new Connector();
