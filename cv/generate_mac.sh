pandoc -t html5 --mathjax -V geometry:margin=1in -s "--include-before-body=_beforebody.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" cv_fr.markdown -o cv.html
pandoc cv_fr.markdown -o cv_default_style_fr.pdf
pandoc cv_fr.markdown -o cv_default_style_fr.docx


pandoc -t html5 --mathjax -V geometry:margin=1in -s "--include-before-body=_beforebody.html" "--include-after-body=_footer.html" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" "--css=https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" "--css=custom.css" cv_en.markdown -o cv_en.html
pandoc cv_en.markdown -o cv_default_style_en.pdf
pandoc cv_en.markdown -o cv_default_style_en.docx