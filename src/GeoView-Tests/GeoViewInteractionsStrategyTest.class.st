Class {
	#name : #GeoViewInteractionsStrategyTest,
	#superclass : #SmockInteractionsStrategyTest,
	#category : #'GeoView-Tests-Events'
}

{ #category : #running }
GeoViewInteractionsStrategyTest >> strategyClass [

	^ GeoViewInteractionsStrategy
]

{ #category : #tests }
GeoViewInteractionsStrategyTest >> testAllowMapMoving [

	self assert: strategy allowMapMoving.

	strategy allowMapMoving: false.
	self deny: strategy allowMapMoving.

	strategy allowMapMoving: true.
	self assert: strategy allowMapMoving
]

{ #category : #tests }
GeoViewInteractionsStrategyTest >> testAllowMapScaling [

	self assert: strategy allowMapScaling.

	strategy allowMapScaling: false.
	self deny: strategy allowMapScaling.

	strategy allowMapScaling: true.
	self assert: strategy allowMapScaling
]

{ #category : #tests }
GeoViewInteractionsStrategyTest >> testGeoView [

	| geoView |
	geoView := GeoViewElement new.

	self assert: strategy geoView isNil.

	strategy geoView: geoView.
	self assert: strategy geoView notNil.
	self assert: strategy target equals: geoView.
	
	strategy geoView: nil.
	self assert: strategy geoView isNil.
	self assert: strategy target isNil.

]
