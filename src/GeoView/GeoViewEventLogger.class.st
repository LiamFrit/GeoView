Class {
	#name : #GeoViewEventLogger,
	#superclass : #BlCustomEventHandler,
	#category : #'GeoView-Events'
}

{ #category : #'api - accessing' }
GeoViewEventLogger >> eventsToHandle [

	^ {
		  GeoViewCursorCoordinatesChangedEvent.
		  GeoViewCenterChangedEvent.
		  GeoViewScaleChangedEvent.
		  GeoViewLayerAddedEvent.
		  GeoViewLayerRemovedEvent.
		  GeoViewLayerReachMaximumDisplayedObjectsEvent.
		  GeoViewDomainObjectsLayerProcessDataChanged }
]

{ #category : #events }
GeoViewEventLogger >> geoViewCenterChangedEvent: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewCursorCoordinatesChangedEvent: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewDomainObjectsLayerProcessDataChanged: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewGraphicModelLayerNeedToBeSorted: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewLayerAddedEvent: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewLayerReachMaximumDisplayedObjectsEvent: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewLayerRemovedEvent: anEvent [

	anEvent traceCr.
]

{ #category : #events }
GeoViewEventLogger >> geoViewScaleChangedEvent: anEvent [

	anEvent traceCr.
]
