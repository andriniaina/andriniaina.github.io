@ECHO OFF
SET RUBY_BIN=d:\dev\Ruby200\bin\

REM Add RUBY_BIN to the PATH
REM RUBY_BIN takes higher priority to avoid other tools
REM conflict with our own (mainly the DevKit)
SET PATH=%RUBY_BIN%;%PATH%;d:\dev\Python27\
SET RUBY_BIN=

REM Display Ruby version
chcp 65001
ruby.exe -v
jekyll serve --watch
