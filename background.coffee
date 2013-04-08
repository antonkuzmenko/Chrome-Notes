app = chrome.app

app.runtime.onLaunched.addListener ->
  app.window.create 'index.html',
    bounds:
      width: 600,
      height: 400,
      left: 0,
      top: 0
    minWidth: 500,
    minHeight: 400,

chrome.runtime.onSuspend.addListener ->
