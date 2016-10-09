// @flow

import Attachment from './attachment';

export type Message = {
  user: string,
  icon: ?string,
  ts: number,
  test: string,
  attachments: Attachment
};
