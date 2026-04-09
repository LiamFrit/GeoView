Class {
	#name : #GeoViewPickingFromCircleResultTest,
	#superclass : #SmockPickingFromCircleResultTest,
	#category : #'GeoView-Tests-Picking'
}

{ #category : #running }
GeoViewPickingFromCircleResultTest >> pickingResultClass [

	^ GeoViewPickingFromCircleResult
]

{ #category : #tests }
GeoViewPickingFromCircleResultTest >> testAbsoluteCenter [

	self assert: result absoluteCenter isNil.

	result absoluteCenter: AbsoluteCoordinates zero.
	self assert: result absoluteCenter equals: AbsoluteCoordinates zero
]

{ #category : #tests }
GeoViewPickingFromCircleResultTest >> testCartesianCenter [

	self assert: result cartesianCenter isNil.

	result cartesianCenter: CartesianCoordinates zero.
	self assert: result cartesianCenter equals: CartesianCoordinates zero
]
