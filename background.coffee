app = chrome.app

app.runtime.onLaunched.addListener ->
  app.window.create 'index.html',
    defaultWidth: 800,
    minWidth: 600
    defaultHeight: 400
    minHeight: 400
    id: 'chrome-notes'

chrome.runtime.onSuspend.addListener ->
