Class {
	#name : #GeoViewPickingFromPointResultTest,
	#superclass : #SmockPickingFromPointResultTest,
	#category : #'GeoView-Tests-Picking'
}

{ #category : #running }
GeoViewPickingFromPointResultTest >> pickingResultClass [

	^ GeoViewPickingFromPointResult
]

{ #category : #tests }
GeoViewPickingFromPointResultTest >> testAbsoluteCoordinates [

	self assert: result absoluteCoordinates isNil.

	result absoluteCoordinates: AbsoluteCoordinates zero.
	self assert: result absoluteCoordinates equals: AbsoluteCoordinates zero
]

{ #category : #tests }
GeoViewPickingFromPointResultTest >> testCartesianCoordinates [

	self assert: result cartesianCoordinates isNil.

	result cartesianCoordinates: CartesianCoordinates zero.
	self assert: result cartesianCoordinates equals: CartesianCoordinates zero
]
