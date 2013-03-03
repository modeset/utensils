#= require utensils/directional
fixture.preload 'directional/markup/directional'

describe 'Directional', ->

  beforeEach ->
    fixture.load 'directional/markup/directional'
    @dom = $(fixture.el)

    @north_el = @dom.find('#north_direc')
    @south_el = @dom.find('#south_direc')
    @east_el = @dom.find('#east_direc')
    @west_el = @dom.find('#west_direc')

    @north_direc = new utensils.Directional(@north_el, @dom, 'north')
    @south_direc = new utensils.Directional(@south_el, @dom, 'south')
    @east_direc = new utensils.Directional(@east_el, @dom, 'east')
    @west_direc = new utensils.Directional(@west_el, @dom, 'west')

  afterEach ->
    $('.demo').remove()
    @dom.css(top:0, left:0, bottom:"auto", right:"auto")


  describe '#constructor', ->
    it 'constructs the class with parameters', ->
      expect(@north_direc.element).to.be @north_el
      expect(@north_direc.container).to.be @dom
      expect(@north_direc.cardinal).to.be 'north'

    it 'returns a list of directional cardinals', ->
      expect(@north_direc.getCardinals()).to.be 'north south east west'


  describe '#getPlacementAndConstrain', ->
    it 'wraps #getPlacementFromCardinal and #constrainToViewport methods and does not alter', ->
      @dom.css(width:'auto', top:200, left:0)
      pos = @east_direc.getPlacementAndConstrain()
      expect(pos.cardinal).to.be 'east'

    it 'wraps #getPlacementFromCardinal and #constrainToViewport methods and alters', ->
      @dom.css(width:'auto', top:200, right:0)
      pos = @east_direc.getPlacementAndConstrain()
      expect(pos.cardinal).to.be 'west'


  describe '#getPlacementFromCardinal', ->
    it 'places an item north of the link', ->
      pos = @north_direc.getPlacementFromCardinal()
      elp = @north_el.offset().top
      expect(pos.top).to.be.below elp
      expect(pos.cardinal).to.be 'north'

    it 'places an item south of the link', ->
      pos = @south_direc.getPlacementFromCardinal()
      elp = @south_el.offset().top
      expect(pos.top).to.be.above elp
      expect(pos.cardinal).to.be 'south'

    it 'places an item east of the link', ->
      pos = @east_direc.getPlacementFromCardinal()
      elp = @east_el.offset().left
      expect(pos.left).to.be.above elp
      expect(pos.cardinal).to.be 'east'

    it 'places an item west of the link', ->
      pos = @west_direc.getPlacementFromCardinal()
      elp = @west_el.offset().left
      expect(pos.left).to.be.below elp
      expect(pos.cardinal).to.be 'west'


  # These tests sometimes fail when there are other errors,
  # we are testing for position here, so in failing tests
  # postions are sometimes awkward
  describe '#constrainToViewport', ->
    it 'repositions the item on stage when north is offscreen', ->
      @dom.css(left:'50%')
      pos = @north_direc.getPlacementFromCardinal()
      suggested = @north_direc.constrainToViewport(pos)
      expect(suggested.cardinal).to.be 'south'

    it 'repositions the item on stage when south is offscreen', ->
      @dom.css(width:'auto', top:'auto', bottom:-400000, left:'50%') # the bottom is set really low because when we're building the report it can be long
      pos = @south_direc.getPlacementFromCardinal()
      suggested = @south_direc.constrainToViewport(pos)
      expect(suggested.cardinal).to.be 'north'

    it 'repositions the item on stage when east is offscreen', ->
      @dom.css(position:'absolute', top:0, right:0)
      pos = @east_direc.getPlacementFromCardinal()
      suggested = @east_direc.constrainToViewport(pos)
      expect(suggested.cardinal).to.be 'west'

    it 'repositions the item on stage when west is offscreen', ->
      @dom.css(position:'absolute', top:0, left:0)
      pos = @west_direc.getPlacementFromCardinal()
      suggested = @west_direc.constrainToViewport(pos)
      expect(suggested.cardinal).to.be 'east'


  describe '#getDimensions', ->
    it 'returns dimensions of an element', ->
      dimensions = @north_direc.getDimensions(@north_el)
      expect(dimensions.top).to.be @north_el.offset().top
      expect(dimensions.left).to.be @north_el.offset().left
      expect(dimensions.width).to.be @north_el.outerWidth()
      expect(dimensions.height).to.be @north_el.outerHeight()

