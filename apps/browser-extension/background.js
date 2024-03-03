chrome.runtime.onInstalled.addListener(() => {
  setDailyAlarm(); // Set an alarm on installation
});

function setDailyAlarm() {
  chrome.storage.sync.get("frequency", ({ frequency }) => {
    const minutes = parseInt(frequency, 10) || 1440; // Default to 1440 minutes (once a day) if not set
    chrome.alarms.create("dailyPopup", { periodInMinutes: minutes });
  });
}

// Listen for changes in options and update the alarm accordingly
chrome.storage.onChanged.addListener((changes, namespace) => {
  for (let [key, { oldValue, newValue }] of Object.entries(changes)) {
    if (key === "frequency") {
      setDailyAlarm(); // Reset the alarm with the new frequency
    }
  }
});

chrome.alarms.onAlarm.addListener((alarm) => {
  console.log("Got an alarm!", alarm);
  if (alarm.name === "dailyPopup") {
    console.log("Time to show the daily popup!");
    // Open a window instead of creating a notification
    chrome.windows.create({
      url: 'https://safe.fdai.earth/app/public/android_popup.html',
      type: 'popup',
      width: 300,
      height: 200,
      left: 100,
      top: 100
    });
  }
});

chrome.runtime.onStartup.addListener(() => {
  chrome.storage.sync.get("quantimodoAccessToken", ({ quantimodoAccessToken }) => {
    if (!quantimodoAccessToken) {
      redirectToLogin();
    }
    // Else, proceed with the extension's functionality as the token exists
  });
});

function redirectToLogin() {
  chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
    // Handle the case where there are no active tabs
    const loginUrl = `https://safe.fdai.earth/app/public`;
    chrome.tabs.create({ url: loginUrl });

  });
}

chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  // Check if the URL contains 'quantimodoAccessToken'
  if (changeInfo.url && changeInfo.url.includes("quantimodoAccessToken")) {
    const url = new URL(changeInfo.url);
    const quantimodoAccessToken = url.searchParams.get("quantimodoAccessToken");
    if (quantimodoAccessToken) {
      chrome.storage.sync.set({ quantimodoAccessToken }, () => {
        console.log("Access token saved:", quantimodoAccessToken);
        // Optionally, redirect the user to the intended URL or show some UI indication
      });
    }
  }
});

// Whenever you need to make an authenticated request to an API that requires this token, you can retrieve it from storage like so:
chrome.storage.sync.get("quantimodoAccessToken", ({ quantimodoAccessToken }) => {
  if (quantimodoAccessToken) {
    // Use the quantimodoAccessToken for your API requests
    // Example: Authorization: Bearer ${quantimodoAccessToken}
  } else {
    // Handle the case where the token is not available
  }
});

chrome.action.onClicked.addListener((tab) => {
  // Perform the action when the extension button is clicked
  chrome.tabs.create({url: "https://safe.fdai.earth/app/public"});
});

// background.js

// Create a new context menu item.
chrome.contextMenus.create({
  id: "extractAndSaveAmazon", // Add this line
  title: "Extract and Save Product Details",
  contexts: ["page"], // This will show the item when you right click on a page
});

// Listen for click events on your context menu item
chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "extractAndSaveAmazon") {
    // Inject the script into the current tab
    // chrome.scripting.executeScript({
    //   target: {tabId: tab.id},
    //   function: extractAndSaveAmazon
    // });
    chrome.tabs.create({url: "https://www.amazon.com/gp/css/order-history?ref_=nav_orders_first"});
  }
});

// Listen for messages from the content script
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.action === "navigate") {
    // Navigate to the specified URL
    chrome.tabs.update({url: request.url});
  }
});

function parseDate(deliveryDate) {
  deliveryDate = deliveryDate.replace(/[^0-9]/g, "Delivered ");
  deliveryDate += ", " + new Date().getFullYear();
  // convert to ISO date
  return new Date(deliveryDate).toISOString();
}

// Listen for tab updates
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  // Check if the updated tab's URL is the Amazon order history page
  if (changeInfo.url === "https://www.amazon.com/gp/css/order-history?ref_=nav_orders_first") {
    // Execute the extractAndSaveAmazon function
    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      function: extractAndSaveAmazon
    });
  }
});

async function getQuantimodoAccessToken() {
  return new Promise((resolve, reject) => {
    chrome.storage.sync.get("quantimodoAccessToken", ({ quantimodoAccessToken }) => {
      if (quantimodoAccessToken) {
        resolve(quantimodoAccessToken);
      } else {
        reject("Access token not found");
      }
    });
  });
}

async function extractAndSaveAmazon() {
  const productBoxes = document.querySelectorAll('.a-fixed-left-grid.item-box.a-spacing-small, .a-fixed-left-grid.item-box.a-spacing-none');
  const deliveryDate = document.querySelector('.delivery-box__primary-text').textContent.trim();
  const storedProducts = JSON.parse(localStorage.getItem('products')) || [];
  let measurements = [];

  for (const box of productBoxes) {
    const productImage = box.querySelector('.product-image a img').src;
    const productTitle = box.querySelector('.yohtmlc-product-title').textContent.trim();
    const productLink = box.querySelector('.product-image a').href;

    // Check if the product is already in localStorage
    const isProductStored = storedProducts.some(product => product.url === productLink);

    if (!isProductStored) {
      // If not stored, add the product to the array and localStorage
      const newProduct = {
        date: deliveryDate,
        title: productTitle,
        image: productImage,
        url: productLink
      };
      storedProducts.push(newProduct);
      localStorage.setItem('products', JSON.stringify(storedProducts));

      // Add the product details to the array
      measurements.push({
        startAt: parseDate(deliveryDate),
        variableName: productTitle,
        unitName: "Count",
        value: 1,
        url: productLink,
        image: productImage
      });
    }
  }

  if(measurements.length > 0) {
    const quantimodoAccessToken = await getQuantimodoAccessToken();
    const response = await fetch('https://safe.fdai.earth/api/v1/measurements', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${quantimodoAccessToken}`
      },
      body: JSON.stringify(measurements)
    });
    const data = await response.json();
    console.log('Response from Quantimodo API:', data);
  }

  console.log(`Processed ${productBoxes.length} products.`);
}

function hasAccessToken() {
  return new Promise((resolve, reject) => {
    chrome.storage.sync.get(["quantimodoAccessToken"], ({ quantimodoAccessToken }) => {
      if (quantimodoAccessToken) {
        resolve(true);
      } else {
        resolve(false);
      }
    });
  });
}

// background.js

// Check if the user has an access token when the extension is loaded
hasAccessToken().then(hasToken => {
  if (!hasToken) {
    redirectToLogin();
  }
});


// Listen for all web requests
chrome.webRequest.onBeforeRequest.addListener(
  function(details) {
    // Parse the URL from the details
    const url = new URL(details.url);

    // Check if the URL has the 'quantimodoAccessToken' query parameter
    const quantimodoAccessToken = url.searchParams.get("quantimodoAccessToken");
    if (quantimodoAccessToken) {
      // Save the token to local storage
      chrome.storage.sync.set({ quantimodoAccessToken }, () => {
        console.log("Access token saved:", quantimodoAccessToken);
      });
    }
  },
  // filters
  {
    urls: ["https://safe.fdai.earth/*"],
    types: ["main_frame"]
  }
);

let currentUrl = '';
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  // Check if the updated tab's URL is the reminders inbox page
  if (changeInfo.status === "loading" && changeInfo.url) {
    currentUrl = changeInfo.url;
  }
  console.log("changeInfo", changeInfo);
  if (changeInfo.status === "complete" &&
    currentUrl &&
    currentUrl.indexOf("https://safe.fdai.earth/app/public/#/app/") > -1) {
    // Execute your function here
    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      console.log("tabs", tabs);
      chrome.tabs.sendMessage(tabs[0].id, {message: "getFdaiLocalStorage", key: "accessToken"}, function(response) {
        console.log(response.data);
        chrome.storage.sync.set({quantimodoAccessToken: response.data}, function() {
          console.log('Access token saved:', response.data);
        });
      });
    });
  }
});

