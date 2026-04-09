Trait {
	#name : #GeoViewManagerPickingServices,
	#traits : 'MolComponentServices',
	#classTraits : 'MolComponentServices classTrait',
	#category : #'GeoView-Molecule-Contract'
}

{ #category : #'services - picking' }
GeoViewManagerPickingServices >> pickAt: aGlobalPoint [
	"Return all objects under a point"
]

{ #category : #'services - picking' }
GeoViewManagerPickingServices >> pickAt: aGlobalPoint distance: aDistanceInPixels [
	"Return all objects under a point and a distance"
]
