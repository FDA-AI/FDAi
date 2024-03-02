console.log('contentScriptForFdai.js loaded');
chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    console.log('contentScriptForFdai.js received a message', request);
    debugger
    if (request.message === "getFdaiLocalStorage") {
      debugger
      sendResponse({data: localStorage.getItem(request.key)});
    }
  }
);

