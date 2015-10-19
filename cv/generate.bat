pandoc -t html5 --mathjax -s "--include-before-body=_header.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" .\cv.markdown -o cv.html
.\cv.html
