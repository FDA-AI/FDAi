import { TriggerClient } from "@trigger.dev/sdk";

export const client = new TriggerClient({
  id: "the-decentralized-fda-1W-N",
  apiKey: process.env.TRIGGER_API_KEY,
  apiUrl: process.env.TRIGGER_API_URL,
});
