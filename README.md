ubuilder
===========

Simple lib to help you build paths for some DSL code:

e.g:

```coffee
ubuilder = require 'ubuilder'

ubuilder.add({path: 'project', id: 1})
  .add({path: 'tasks', 'rules': [{need: 'projects'}]})
  .build() #/project/1/tasks.json
```

**This will allow you to create codes like:**

```coffee
teamwork.project(1).tasks().get (err, response, body) ->
  console.log body

class Teamwork
  project: (id) ->
    ubuilder.add({path: 'project', id: 1});
  tasks: ->
    ubuilder.add({path: 'tasks', rules: [{need: 'project'}]})
    
  get: (callback) ->
    request(ubuilder.build(), callback)
```


## License

Licensed under <a href="http://krolow.mit-license.org/">The MIT License</a>
Redistributions of files must retain the above copyright notice.

## Author

Vinícius Krolow - krolow[at]gmail.com
