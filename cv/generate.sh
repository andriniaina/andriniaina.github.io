pandoc -t html5 --mathjax -s "--include-before-body=_header.html" "--include-before-body=_beforedoc.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" ./cv.markdown -o cv.html
pandoc -V geometry:margin=1in ./cv.markdown -o cv_default_style.pdf
#pandoc -f gfm ./cv.markdown -o cv_gfm.pdf
#pandoc -f markdown_mmd ./cv.markdown -o cv_mmd.pdf
