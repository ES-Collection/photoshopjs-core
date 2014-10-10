{desc, ref, list} = require 'photoshopjs-com'

module.exports = class Layer

	constructor: (@_manager, @id, @descriptor) ->

		@_ref = null

	getName: ->

		@getReference().execGet().getStr "name"

	setName: (name) ->

		do @activate

		desc()
		.ref 'null', @getReference()
		.obj 'to', 'layer', desc().str 'name', name
		.exec "set"

		@

	isActive: ->

		a = @_manager.getActive()

		a.length is 1 and a[0] is @

	activate: ->

		return @ if @isActive()

		@_manager.activate @

		@

	getReference: ->

		unless @_ref?

			@_ref = ref().ident 'layer', @id

		@_ref

	self = @

	@extend: (obj) ->

		for own name, val of obj

			if hasProp.call self.prototype, name

				throw Error "Layer already has a prop named '#{name}'"

			self.prototype[name] = val

		self

hasProp = {}.hasOwnProperty

require './layer/transforms'
require './layer/fill'