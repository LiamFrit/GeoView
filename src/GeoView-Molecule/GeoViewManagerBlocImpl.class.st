Class {
	#name : #GeoViewManagerBlocImpl,
	#superclass : #GeoViewManagerImpl,
	#category : #'GeoView-Molecule-Impl'
}

{ #category : #initialization }
GeoViewManagerBlocImpl >> createView [

	| element |
	element := GeoViewElement new.
	self installEventHandlers: element.

	self view: element
]

{ #category : #initialization }
GeoViewManagerBlocImpl >> installEventHandlers: aBlElement [

	"Layers events"
	aBlElement addEventHandlerOn: GeoViewDomainObjectsLayerProcessDataChanged do: [ :e | self layerHasBeenUpdated: e ].
	aBlElement addEventHandlerOn: GeoViewLayerAddedEvent do: [ :e | self layerAdded: e ]. 
	aBlElement addEventHandlerOn: GeoViewLayerRemovedEvent do: [ :e | self layerRemoved: e ]. 
	
	"View changed events"
	aBlElement addEventHandlerOn: GeoViewMapProjectionChangedEvent do: [ :e | self mapProjectionHasChanged: e ]. 
	aBlElement addEventHandlerOn: GeoViewCenterChangedEvent do: [ :e | self centerHasChanged: e ]. 
	aBlElement addEventHandlerOn: GeoViewScaleChangedEvent do: [ :e | self scaleHasChanged: e ]. 

	"Selection events"
	aBlElement addEventHandlerOn: SmockObjectSelectionChanged do: [ :e | self strategyRequestSetSelection: e objectIndexesList ].
	aBlElement addEventHandlerOn: SmockObjectSelectionAdded do: [ :e | self strategyRequestAddSelection: e objectIndexesList ].
	aBlElement addEventHandlerOn: SmockObjectSelectionRemoved do: [ :e | self strategyRequestRemoveSelection: e objectIndexesList ].
	aBlElement addEventHandlerOn: SmockObjectSelectionCleared do: [ :e | self strategyRequestClearSelection ]
]
