"
This class define default user interactions (using Bloc event handler) with a geo view.
This class provided classical mouse and keyboard ergonomic to move, scale and select objets.
"
Class {
	#name : #GeoViewInteractionsStrategy,
	#superclass : #SmockInteractionsStrategy,
	#instVars : [
		'allowMapMoving',
		'allowMapScaling',
		'isMapMoving',
		'rectangleSelectionEventHandler'
	],
	#category : #'GeoView-Events'
}

{ #category : #'API -- configuration' }
GeoViewInteractionsStrategy >> allowMapMoving [

	^ allowMapMoving ifNil:[ allowMapMoving := true ]
]

{ #category : #'API -- configuration' }
GeoViewInteractionsStrategy >> allowMapMoving: aBoolean [
	
	allowMapMoving := aBoolean
]

{ #category : #'API -- configuration' }
GeoViewInteractionsStrategy >> allowMapScaling [

	^ allowMapScaling ifNil:[ allowMapScaling := true ]
]

{ #category : #'API -- configuration' }
GeoViewInteractionsStrategy >> allowMapScaling: anObject [

	allowMapScaling := anObject
]

{ #category : #'API -- configuration' }
GeoViewInteractionsStrategy >> allowRectangleSelection: aBoolean [

	| previous |
	previous := allowRectangleSelection.
	super allowRectangleSelection: aBoolean.
	previous ~= aBoolean ifFalse:[ ^ self ].
			
	aBoolean ifFalse:[
		self uninstallRectangleSelectionEventHandler.
	] ifTrue:[
		self allowSelection ifTrue:[ self installRectangleSelectionEventHandler ].
	].
]

{ #category : #'dnd handlers' }
GeoViewInteractionsStrategy >> dragEndEvent: anEvent [

	self isMapMoving: false.
]

{ #category : #accessing }
GeoViewInteractionsStrategy >> geoView [

	^ self target
]

{ #category : #accessing }
GeoViewInteractionsStrategy >> geoView: aGeoViewOrNil [

	self target ifNotNil:[
		self uninstallRectangleSelectionEventHandler.	
	].

	self target: aGeoViewOrNil.
	
	self target ifNotNil: [
		self allowRectangleSelection ifTrue:[
			self installRectangleSelectionEventHandler
		].
	] 
]

{ #category : #initialization }
GeoViewInteractionsStrategy >> initialize [ 

	super initialize.
	
	self initializeRectangleSelectionEventHandler.
]

{ #category : #private }
GeoViewInteractionsStrategy >> initializeRectangleSelectionEventHandler [

	rectangleSelectionEventHandler := GeoViewRectangleSelectionEventHandler new
]

{ #category : #private }
GeoViewInteractionsStrategy >> installRectangleSelectionEventHandler [
		
	self geoView ifNil:[ ^ self ].
	(self geoView hasEventHandler: rectangleSelectionEventHandler) ifTrue:[ ^ self ]. 
	
	self geoView addEventHandler: rectangleSelectionEventHandler
]

{ #category : #accessing }
GeoViewInteractionsStrategy >> isMapMoving [

	^ isMapMoving ifNil: [ isMapMoving := false ]
]

{ #category : #accessing }
GeoViewInteractionsStrategy >> isMapMoving: aBoolean [

	isMapMoving := aBoolean
]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> mouseDownEvent: anEvent [

	self mouseDownPosition: anEvent position.
	self allowMapMoving ifTrue:[ self isMapMoving: true ].
]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> mouseMoveEvent: anEvent [

	"Sampling mouse events"
	lastMouseMoveEventTimestamp ifNotNil:[ | duration |
		duration := anEvent timestamp - lastMouseMoveEventTimestamp.
		duration < self pulseDuration ifTrue:[ ^ self ].  
	].
	lastMouseMoveEventTimestamp := anEvent timestamp copy.

	self sendMouseCoordinatesChanged: anEvent.
	
	"Process mouse map moving"
	(self allowMapMoving and: [ self isMapMoving ]) ifTrue:[ 
		self moveMap: anEvent ].

]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> mouseUpEvent: anEvent [
	
	self mouseDownPosition: nil.
	self isMapMoving: false.
]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> mouseWheelEvent: anEvent [
	"Scale the map(zoom in or zoom out) but stay centered behind the mouse position"
	
	| point mapProjection graphicProjection geoPoint geoPointPx geoCenterPx difPx geoPointPxNew newPointPx geoPointFinal |

	self allowMapScaling ifFalse:[ ^ self ].

	point := self geoView localPointFromGlobalPoint: anEvent position.
	
	mapProjection := self geoView mapProjection ifNil:[ ^ self ].
	graphicProjection := self geoView displayToGraphicProjection ifNil:[ ^ self ].

	geoPoint := self geoView absoluteCoordinatesFromLocalPoint: point.
	geoPointPx := graphicProjection projCartToPixel: (mapProjection projLatLonToCart: geoPoint).
	geoCenterPx := graphicProjection projCartToPixel: (mapProjection projLatLonToCart: self geoView geoCenter).
	
	geoPointPx ifNil:[ ^ self ].
	geoCenterPx ifNil:[ ^ self ].
	
	"Compute diff from mouse position to view center in pixel before scale"
	difPx := geoCenterPx - geoPointPx.
	
	"Scale"
	anEvent isScrollDown 
		ifTrue: [ self geoView scaleDown ] 
		ifFalse:[ anEvent isScrollUp ifTrue: [ self geoView scaleUp ] ifFalse:[ ^ self ] ].
	
	self allowMapMoving ifFalse:[ ^ self ].
	
	"compute new position in pixel for the mouse position before zoom"
	
	geoPointPxNew := graphicProjection projCartToPixel: (mapProjection projLatLonToCart: geoPoint).
	"add the previous diff in pixels to get new center in pixel"
	newPointPx := geoPointPxNew + difPx.
	"Compute new position in cartesian for new center"
	geoPointFinal := self geoView absoluteCoordinatesFromLocalPoint: newPointPx.
	self geoView geoCenter: geoPointFinal.
]

{ #category : #'events - processing' }
GeoViewInteractionsStrategy >> moveMap: anEvent [ 

	| point difPx geoCenterPx |
	
	self mouseDownPosition ifNil:[ ^ self ].
		
	point := anEvent position.
	difPx := self mouseDownPosition - point.
	difPx := difPx x @ difPx y.
	geoCenterPx := self geoView globalPointFromAbsoluteCoordinates: self geoView geoCenter.
	geoCenterPx ifNil: [ ^ self ].
	geoCenterPx := geoCenterPx + difPx.

	self isMapMoving: true.
	self mouseDownPosition: point copy.
	self geoView centerOnGlobalPoint: geoCenterPx.
]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> primaryClickEvent: anEvent [
	
	self allowSelection ifFalse:[ ^ self ].
	self isMapMoving ifTrue:[ ^ self ].
	
	self selectOnClick: anEvent 
]

{ #category : #'events - accessing' }
GeoViewInteractionsStrategy >> rectangleSelectionEventHandler [

	^ rectangleSelectionEventHandler
]

{ #category : #'events - accessing' }
GeoViewInteractionsStrategy >> rectangleSelectionEventHandler: anEventHandler [

	self uninstallRectangleSelectionEventHandler.

	rectangleSelectionEventHandler := anEventHandler.
	
	self allowRectangleSelection ifTrue:[ self installRectangleSelectionEventHandler ].
]

{ #category : #'mouse handlers' }
GeoViewInteractionsStrategy >> secondaryClickEvent: anEvent [
	
	self allowSelection ifFalse:[ ^ self ].
	self isMapMoving ifTrue:[ ^ self ].
	
	self selectOnClick: anEvent
]

{ #category : #'events - processing' }
GeoViewInteractionsStrategy >> sendMouseCoordinatesChanged: anEvent [

	| coordinates event |
	
	"Calculate the absolute coordinates (lat/lon) under the mouse cursor"
	coordinates := self geoView absoluteCoordinatesFromGlobalPoint: anEvent position.
	coordinates ifNil:[ ^ self ].
	
	event := GeoViewCursorCoordinatesChangedEvent new.
	event absoluteCoordinates: coordinates.
	self geoView dispatchEvent: event.
]

{ #category : #private }
GeoViewInteractionsStrategy >> uninstallRectangleSelectionEventHandler [
		
	self geoView ifNil:[ ^ self ].
	(self geoView hasEventHandler: rectangleSelectionEventHandler) ifFalse:[ ^ self ]. 
	
	self geoView removeEventHandler: rectangleSelectionEventHandler
]
