my_finance
==========

Simple financial accounting

Install
---

`git clone git@github.com:sdilshod/my_finance.git `

`cd ./my_finance`

`bundle`

In this app used npm package management and need to install it

`sudo apt-get install npm`

`npm install -g node`

`npm install -g bower`

Setup db and you may populate db with seeds

`rake db:create` 

`rake db:migrate` 

`rake db:seed`

Run local server with `rails s` and go to `localhost:3000`

Deploy to heroku
----

As in this app used packaging system like bower, need to some configurations for heroku. Read https://coderwall.com/p/6bmygq/heroku-rails-bower for it
