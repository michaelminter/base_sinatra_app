#Base Sinatra Application
A baseline Sinatra application

##Dependencies
Server

* Ruby

Gems

* sinatra
* rack
* rack-protection
* tilt
* shotgun

##Running
`rackup config.ru`

To change the default port:

`rackup -p 2323 config.ru`

To run with update on every request:

`shotgun config.ru`
