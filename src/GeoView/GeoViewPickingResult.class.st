Class {
	#name : #GeoViewPickingResult,
	#superclass : #SmockPickingResult,
	#instVars : [
		'cartesianCoordinates',
		'absoluteCoordinates'
	],
	#category : #'GeoView-Picking'
}

{ #category : #testing }
GeoViewPickingResult class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
GeoViewPickingResult >> absoluteCoordinates [
	^ absoluteCoordinates
]

{ #category : #accessing }
GeoViewPickingResult >> absoluteCoordinates: anObject [
	absoluteCoordinates := anObject
]

{ #category : #accessing }
GeoViewPickingResult >> cartesianCoordinates [
	^ cartesianCoordinates
]

{ #category : #accessing }
GeoViewPickingResult >> cartesianCoordinates: anObject [
	cartesianCoordinates := anObject
]
