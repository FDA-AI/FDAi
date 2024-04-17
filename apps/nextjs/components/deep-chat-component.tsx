"use client";

// !!Useful links at the bottom!!
// import {DeepChat as DeepChatCore} from 'deep-chat'; <- type
//import styles from './style.module.css';
import dynamic from 'next/dynamic';

export default function DeepChatComponent() {
  return         <FullPageChat
    chatflowid="3a94fd29-fbe1-4318-a67b-a3fb5b6f74a8"
    apiHost="https://fw.fdai.earth"
    theme={{
      chatWindow: {
        welcomeMessage: "Hello! This is custom welcome message",
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

  const initialMessages = [
    {
      html: `
      <div class="deep-chat-temporary-message">
        <button class="deep-chat-button deep-chat-suggestion-button" style="margin-top: 5px">What do shrimps eat?</button>
        <button class="deep-chat-button deep-chat-suggestion-button" style="margin-top: 6px">Can a shrimp fry rice?</button>
        <button class="deep-chat-button deep-chat-suggestion-button" style="margin-top: 6px">What is a pistol shrimp?</button>
      </div>`,
      role: 'ai',
    },
    // { role: 'user', text: 'Hey, how are you today?' },
    // { role: 'ai', text: 'I am doing very well!' },
  ];

  // need to import the component dynamically as it uses the 'window' property
  const DeepChat = dynamic(
    () => import('deep-chat-react').then((mod) => mod.DeepChat),
    {
      ssr: false,
    }
  );

  // demo/style/textInput are examples of passing an object directly into a property
  // initialMessages is an example of passing a state object into the property
  return (
    <>
      <main>
        <h1>Deep Chat</h1>
        <DeepChat
          demo={true}
          style={{ borderRadius: '10px' }}
          textInput={{ placeholder: { text: 'Welcome to the demo!' } }}
          initialMessages={initialMessages}
          messageStyles={{html: {shared: {bubble: {backgroundColor: 'unset', padding: '0px'}}}}}
        />
      </main>
    </>
  );
}

// Info to get a reference for the component:
// https://github.com/OvidijusParsiunas/deep-chat/issues/59#issuecomment-1839483469

// Info to add types to a component reference:
// https://github.com/OvidijusParsiunas/deep-chat/issues/59#issuecomment-1839487740
