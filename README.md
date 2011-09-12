# A poxy little reading queue

Add bookmarks with a javascript bookmarklet like this:

    javascript:function shittyqueue(){var f = document.createElement("form");f.setAttribute("method", 'get');f.setAttribute("action", 'http://shittyqueue.heroku.com/add');var hiddenField = document.createElement("input");hiddenField.setAttribute("type", "hidden");hiddenField.setAttribute("name", 'url');hiddenField.setAttribute("value", document.location.href);f.appendChild(hiddenField);document.body.appendChild(f);f.submit();}shittyqueue();void(0);

but obviously with your own heroku details
