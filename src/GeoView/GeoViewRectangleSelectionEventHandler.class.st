"
This event handler is an example to how to write a rectangle selection.
The rectangle selection used Bloc to draw a rectangle (but should be drawed by any other ways) and GeoView picking and selection API to select objects inside the rectangle.
"
Class {
	#name : #GeoViewRectangleSelectionEventHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'geoView',
		'startPosition',
		'rectangle',
		'rectangleElement'
	],
	#category : #'GeoView-Events'
}

{ #category : #initialization }
GeoViewRectangleSelectionEventHandler >> createRectangleElement [
	
	^ BlElement new
		id: #selectionRectangle;
		zIndex: 1000;
		extent: 1 asPoint;
		border:
			(BlBorder
				paint: Color white
				width: 1);
		effect: (BlGradientShadowEffect color: (Color black alpha: 0.5) width: 2 offset: 0@0);
		yourself
]

{ #category : #'dnd handlers' }
GeoViewRectangleSelectionEventHandler >> dragEndEvent: anEvent [

	anEvent consume.
	
	self geoView inUIProcessDo: [ 
		self geoView childWithId: (self rectangleElement id) ifFound: [ self geoView removeChild: self rectangleElement ]. 
	].
	
	self pickRectangle: anEvent.
	
	startPosition := nil.
	rectangle := nil.
]

{ #category : #'dnd handlers' }
GeoViewRectangleSelectionEventHandler >> dragEvent: anEvent [

	| origin corner |
	anEvent consume.
	
	startPosition ifNil:[ ^ self ].
	
	origin := startPosition.
	corner := self geoView localPointFromGlobalPoint: (anEvent position).
	rectangle := Rectangle point: origin point: corner.
	
	self geoView inUIProcessDo: [ 
		self rectangleElement position: rectangle origin; extent: (rectangle extent) 
	]
]

{ #category : #'dnd handlers' }
GeoViewRectangleSelectionEventHandler >> dragStartEvent: anEvent [

	"Create a rectangle when the Shift key is down"
	anEvent modifiers isShift ifFalse:[ ^ self ].
	
	anEvent consume.
	
	"Place rectangle at start position"
	startPosition := self geoView localPointFromGlobalPoint: (anEvent position).
	self rectangleElement extent: 1 asPoint; position: startPosition.
	
	self geoView inUIProcessDo: [ self geoView addChild: self rectangleElement ]
]

{ #category : #accessing }
GeoViewRectangleSelectionEventHandler >> geoView [

	^ geoView
]

{ #category : #initialization }
GeoViewRectangleSelectionEventHandler >> initialize [
	
	super initialize.
	
	rectangleElement := self createRectangleElement
]

{ #category : #'mouse handlers' }
GeoViewRectangleSelectionEventHandler >> mouseDownEvent: anEvent [

	anEvent modifiers isShift ifFalse:[ ^ self ].
	
	anEvent consume.
	self geoView interactionsStrategy isMapMoving: false
]

{ #category : #'mouse handlers' }
GeoViewRectangleSelectionEventHandler >> mouseMoveEvent: anEvent [

	anEvent modifiers isShift ifFalse:[ ^ self ].
	
	anEvent consume
]

{ #category : #'api - hooks' }
GeoViewRectangleSelectionEventHandler >> onInstalledIn: anObject [

	super onInstalledIn: anObject.
	geoView := anObject
]

{ #category : #'api - hooks' }
GeoViewRectangleSelectionEventHandler >> onUninstalledIn: aGeoView [

	geoView := nil.
	super onUninstalledIn: aGeoView
]

{ #category : #private }
GeoViewRectangleSelectionEventHandler >> pickRectangle: anEvent [

	| pickingResult globalRectangle |
	rectangle ifNil:[ ^ self ].
	
	globalRectangle := (self geoView globalPointFromLocalPoint: rectangle origin) corner: (self geoView globalPointFromLocalPoint: rectangle corner).
	
	pickingResult := self geoView pickInRectangle: globalRectangle.
	self geoView interactionsStrategy processSelectionInPickingResult: pickingResult from: anEvent
]

{ #category : #accessing }
GeoViewRectangleSelectionEventHandler >> rectangleElement [

	^ rectangleElement
]
