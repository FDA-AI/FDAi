const extractAndSaveAmazon = require('../extractAndSaveAmazon');
const fs = require('fs');
const path = require('path');
const jsdom = require("jsdom");
const { JSDOM } = jsdom;

describe('fetch with custom DNS', () => {
  it('should use the system DNS', async () => {
    const response = await fetchWithCustomDns('https://local.quantimo.do');
    expect(response.ok).toBeTruthy();
  });
});

describe('extractAndSaveAmazon function', () => {
    it('should work correctly', async () => {
      const html = fs.readFileSync(path.resolve(__dirname, 'amazon.html'), 'utf8');
      let cleanedHtml = html.replace(/<link rel="stylesheet"[\s\S]*?>/gi, '');
      cleanedHtml = cleanedHtml.replace(/@import url\([^)]+\);/g, '');
      const dom = new JSDOM(cleanedHtml, {
        resources: new jsdom.ResourceLoader({
          fetch(url, options) {
            if ((options.element && options.element.localName === "link" && options.element.rel === "stylesheet") || url.startsWith('http://') || url.startsWith('https://')) {
              // Ignore stylesheets and external resources
              return null;
            }
            // Use the default fetch for non-stylesheet resources
            return jsdom.defaultFetch(url, options);
          }
        })
      });
      const orderCards = dom.window.document.querySelectorAll('.order-card');
      const result = await extractAndSaveAmazon(dom.window.document);
        expect(result).toBe([]);
    });
});
