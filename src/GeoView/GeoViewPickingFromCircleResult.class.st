Class {
	#name : #GeoViewPickingFromCircleResult,
	#superclass : #SmockPickingFromCircleResult,
	#instVars : [
		'cartesianCenter',
		'absoluteCenter'
	],
	#category : #'GeoView-Picking'
}

{ #category : #accessing }
GeoViewPickingFromCircleResult >> absoluteCenter [

	^ absoluteCenter
]

{ #category : #accessing }
GeoViewPickingFromCircleResult >> absoluteCenter: anObject [

	absoluteCenter := anObject
]

{ #category : #accessing }
GeoViewPickingFromCircleResult >> cartesianCenter [

	^ cartesianCenter
]

{ #category : #accessing }
GeoViewPickingFromCircleResult >> cartesianCenter: anObject [

	cartesianCenter := anObject
]

{ #category : #printing }
GeoViewPickingFromCircleResult >> printString [

	| ws string |
	string := super printString.
	ws := WriteStream on: String new.
	ws nextPutAll: string.

	ws space.
	ws nextPutAll: self absoluteCenter printString.
	
	^ ws contents
]
