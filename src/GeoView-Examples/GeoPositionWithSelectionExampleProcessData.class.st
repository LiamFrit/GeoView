"
This process data show how to write a selection render using object states.
The selection is rendered by changing color of the label
"
Class {
	#name : #GeoPositionWithSelectionExampleProcessData,
	#superclass : #GeoPositionProcessData,
	#instVars : [
		'selectionColor'
	],
	#category : #'GeoView-Examples-Utils'
}

{ #category : #processing }
GeoPositionWithSelectionExampleProcessData >> processStateChanged: aKey state: aState value: aValueOrNil with: aDShape context: aContext [

	super processStateChanged: aKey state: aState value: aValueOrNil with: aDShape context: aContext.

	aState = #selected ifTrue:[ | isSelected |
		isSelected := aValueOrNil ifNil:[ false ].
		(aDShape getChild: #text) ifNotNil: [ :label | label fillColor: (isSelected ifTrue:[ self selectionColor ] ifFalse:[ self textColor ]) ]
	].

	^ aDShape
]

{ #category : #accessing }
GeoPositionWithSelectionExampleProcessData >> selectionColor [

	^ selectionColor ifNil:[ selectionColor := Color red ]
]

{ #category : #accessing }
GeoPositionWithSelectionExampleProcessData >> selectionColor: aColor [

	selectionColor := aColor
]
