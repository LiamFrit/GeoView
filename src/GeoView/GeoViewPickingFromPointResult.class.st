Class {
	#name : #GeoViewPickingFromPointResult,
	#superclass : #SmockPickingFromPointResult,
	#instVars : [
		'cartesianCoordinates',
		'absoluteCoordinates'
	],
	#category : #'GeoView-Picking'
}

{ #category : #accessing }
GeoViewPickingFromPointResult >> absoluteCoordinates [

	^ absoluteCoordinates
]

{ #category : #accessing }
GeoViewPickingFromPointResult >> absoluteCoordinates: anObject [

	absoluteCoordinates := anObject
]

{ #category : #accessing }
GeoViewPickingFromPointResult >> cartesianCoordinates [

	^ cartesianCoordinates
]

{ #category : #accessing }
GeoViewPickingFromPointResult >> cartesianCoordinates: anObject [

	cartesianCoordinates := anObject
]

{ #category : #printing }
GeoViewPickingFromPointResult >> printString [

	| ws string |
	string := super printString.
	ws := WriteStream on: String new.
	ws nextPutAll: string.

	ws space.
	ws nextPutAll: self absoluteCoordinates printString.
	
	^ ws contents
]
