mocha = require "mocha"
should = require "should"
ubuilder = require "#{__dirname}/../lib/ubuilder"

describe "ubuilder", ->
  describe "add paths", =>
    it "should add the paths", =>
      ubuilder.add
        test: true
      ubuilder.paths.length.should.be.equal 1
      ubuilder.add
        test2: true
      ubuilder.paths.length.should.be.equal 2
      ubuilder.clean()

    it "should have the paths", =>
      ubuilder.add
        path: 'projects'
      ubuilder.add
        path: 'tasks'
      ubuilder.add
        path: 'task'

      ubuilder.hasPath('projects').should.be.equal true
      ubuilder.hasPath('tasks').should.be.equal true
      ubuilder.hasPath('task').should.be.equal true
      ubuilder.hasPath('task_list').should.be.equal false
      ubuilder.clean()


  describe "clean paths", =>
    ubuilder.add
      path: 'test'
    ubuilder.clean()
    ubuilder.paths.length.should.be.equal 0

  describe "query params", =>
    it "should add the query params", =>
      ubuilder.addQueryParams
        test: true
        working: true
      JSON.stringify(ubuilder.queryParams).should.be.equal JSON.stringify({test: true, working: true})

      ubuilder.queryString().should.be.equal "?test=true&working=true"
      ubuilder.addQueryParams
        sort: -1
      JSON.stringify(ubuilder.queryParams).should.be.equal JSON.stringify({test: true, working: true, sort: -1})
      ubuilder.queryString().should.be.equal "?test=true&working=true&sort=-1"
      ubuilder.clean()

  describe "build path", =>
    it "should generate the right path: /projects.json", =>
      ubuilder.add
        path: 'projects'
      ubuilder.build().should.be.equal '/projects.json'

    it "should generate the right path: /project/1/tasks.json", =>
      ubuilder.clean
      ubuilder.add
        path: 'project'
        id: 1

      ubuilder.add
        path: 'tasks'
        rules: [
          {need: 'project'},
        ]

      ubuilder.build().should.be.equal '/project/1/tasks.json'

    it "should generate the right path: /planet/1/world/water/1.json?quantity=true", =>
      ubuilder.add
        path: 'planet'
        id: 1

      ubuilder.add
        path: 'world'
        rules: [
          {need: 'planet'}
        ]

      ubuilder.add
        path: 'water'
        id: 1

      ubuilder.addQueryParams {quantity: true}
      ubuilder.build().should.be.equal '/planet/1/world/water/1.json?quantity=true'
