// popup.js
document.addEventListener('DOMContentLoaded', function() {
  chrome.storage.sync.get("behavior", ({ behavior }) => {
    if (behavior === "direct") {
      chrome.tabs.create({url: "https://safe.dfda.earth/app/public/#/app/reminders-inbox"});
    } else {
      // Assuming you have a button setup as previously described
      document.getElementById('recordButton').addEventListener('click', function() {
        var redirectUrl = "https://safe.dfda.earth/app/public/#/app/reminders-inbox";
        chrome.tabs.create({url: redirectUrl}, function() {
          window.close(); // Close the popup window
        });
      });
    }
  });

document.getElementById('amazonBtn').addEventListener('click', function() {
  const url = 'https://www.amazon.com/gp/css/order-history';

  chrome.tabs.query({}, function(tabs) {
    let tabExists = false;

    for (let i = 0; i < tabs.length; i++) {
      if (tabs[i].url === url) {
        tabExists = true;
        chrome.tabs.update(tabs[i].id, {active: true, url: url}, function(tab) {
          chrome.tabs.reload(tab.id);
        });
        break;
      }
    }

    if (!tabExists) {
      window.open(url, '_blank');
    }
  });
});

});

