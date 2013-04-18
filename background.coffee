app = chrome.app

app.runtime.onLaunched.addListener ->
  app.window.create 'index.html',
                    defaultWidth: 800,
                    minWidth: 600
                    defaultHeight: 500
                    minHeight: 500
                    id: 'chrome-notes'