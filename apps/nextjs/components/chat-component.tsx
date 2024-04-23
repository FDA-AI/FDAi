"use client";
import { FullPageChat } from 'flowise-embed-react';

export default function ChatComponent() {
  return  <FullPageChat
    chatflowid="3a94fd29-fbe1-4318-a67b-a3fb5b6f74a8"
    apiHost="https://fw.fdai.earth"
    theme={{
      chatWindow: {
        welcomeMessage: "How are you?",
        backgroundColor: "#ffffff",
        height: 700,
        width: 400,
        fontSize: 16,
        poweredByTextColor: "#303235",
        botMessage: {
          backgroundColor: "#f7f8ff",
          textColor: "#303235",
          showAvatar: true,
          avatarSrc: "https://raw.githubusercontent.com/zahidkhawaja/langchain-chat-nextjs/main/public/parroticon.png",
        },
        userMessage: {
          backgroundColor: "#3B81F6",
          textColor: "#ffffff",
          showAvatar: true,
          avatarSrc: "https://raw.githubusercontent.com/zahidkhawaja/langchain-chat-nextjs/main/public/usericon.png",
        },
        textInput: {
          placeholder: "Type your question",
          backgroundColor: "#ffffff",
          textColor: "#303235",
          sendButtonColor: "#3B81F6",
        }
      }
    }}
  />
}
