ubuilder
===========

Simple lib to help you build paths for some DSL code:

e.g:

```coffescript
ubuilder = require 'ubuilder'

ubuilder.add({path: 'projects'})
  .add({path: 'tasks', 'rules': [{need: 'projects'}]})
  .build() #/projects/tasks.json
```

## License

Licensed under <a href="http://krolow.mit-license.org/">The MIT License</a>
Redistributions of files must retain the above copyright notice.

## Author

Vinícius Krolow - krolow[at]gmail.com
