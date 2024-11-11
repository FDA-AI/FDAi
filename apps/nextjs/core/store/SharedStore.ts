import { create } from 'zustand';
import { Message, SuggestionItem } from '../types/types';

interface SharedState {
    suggestions: SuggestionItem[],
    response: string,
    conversation: Message[],
    previousStatements: string,
    previousQuestions: string
}

const useSharedStore = create<SharedState>((set)=>({
    suggestions: [],
    response: "",
    conversation: [],
    previousStatements: "",
    previousQuestions: ""
}));

export default useSharedStore;