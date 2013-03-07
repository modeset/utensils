#= require components/<%= file_name %>
fixture.preload 'components/<%= file_name %>/spec/fixture'

describe '<%= file_name.camelize %>', ->

  beforeEach ->
    fixture.load 'components/<%= file_name %>/spec/fixture'
    @dom = $(fixture.el)
    @noop = ->


  describe 'binding', ->
    it 'is registered in bindable', ->
      expect(utensils.Bindable.getClass('<%= file_name.dasherize %>')).to.be namespace.<%= file_name.camelize %>


  describe.skip 'has not been tested', ->
    it '', ->

