pandoc -s -t html5 --mathjax "--include-before-body=_beforebody.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" ./cv_fr.markdown -o cv.html
pandoc -s -V geometry:margin=1in --template=custom.latex ./cv_fr.markdown -o cv_default_style_fr.pdf

pandoc -s -t html5 --mathjax "--include-before-body=_beforebody.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" ./cv_en.markdown -o cv_en.html
pandoc -s -V geometry:margin=1in --template=custom.latex ./cv_en.markdown -o cv_default_style_en.pdf
