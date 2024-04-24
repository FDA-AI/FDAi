import React, {useCallback, useState} from "react"
import {convertFileToBase64} from "@/app/utils/convertFileToBase64";
import ChatComponent from "@/app/chat/ChatComponent";

const [file, setFile] = useState<File | null>(null); // Holds the selected image file
const [preview, setPreview] = useState<string>(''); // URL for the image preview
const [result, setResult] = useState<string>(''); // Stores the analysis result
const [statusMessage, setStatusMessage] = useState<string>(''); // Displays status messages to the user
const [uploadProgress, setUploadProgress] = useState<number>(0); // Manages the upload progress
const [dragOver, setDragOver] = useState<boolean>(false); // UI state for drag-and-drop
const [textInput, setTextInput] = useState<string>(''); // Custom text input by the user
const [selectedOption, setSelectedOption] = useState<string>('off'); // Option for detail level of analysis
const [maxTokens, setMaxTokens] = useState<number>(50); // Max tokens for analysis
const [base64Image, setBase64Image] = useState<string>('');

// Callback for handling file selection changes
const handleFileChange = useCallback(async (selectedFile: File) => {
  // Updating state with the new file and its preview URL
  setFile(selectedFile);
  setPreview(URL.createObjectURL(selectedFile));
  setStatusMessage('Image selected. Click "Analyze Image" to proceed.');
  setUploadProgress(0);

  // Convert the file to a base64 string and store it in the state
  const base64 = await convertFileToBase64(selectedFile);
  setBase64Image(base64);
}, []);

// Function to handle submission for image analysis
const handleSubmit = async (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
  event.preventDefault();
  if (!file) {
    setStatusMessage('No file selected!');
    return;
  }

  setStatusMessage('Sending request...');
  setUploadProgress(40); // Progress after image conversion

  // Send a POST request to your API endpoint
  const response = await fetch('/api/image2measurements', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      file: base64Image,
      prompt: textInput,
      detail: selectedOption !== 'off' ? selectedOption : undefined,
      max_tokens: maxTokens
    }),
  });

  setUploadProgress(60); // Progress after sending request

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }

  const apiResponse = await response.json();
  setUploadProgress(80); // Progress after receiving response

  if (apiResponse.success) {
    setResult(apiResponse.analysis);
    setStatusMessage('Analysis complete.');
    setUploadProgress(100); // Final progress
  } else {
    setStatusMessage(apiResponse.message);
  }
};

// Callbacks for handling drag-and-drop events
const handleDragOver = useCallback((event: React.DragEvent<HTMLDivElement>) => {
  event.preventDefault();
  setDragOver(true);
}, []);

const handleDragLeave = useCallback(() => {
  setDragOver(false);
}, []);

const handleDrop = useCallback((event: React.DragEvent<HTMLDivElement>) => {
  event.preventDefault();
  setDragOver(false);
  const files = event.dataTransfer.files;
  if (files.length) {
    handleFileChange(files[0]);
  }
}, [handleFileChange]);

