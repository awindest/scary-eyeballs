<script lang="ts">
	// follow the eyes: https://github.com/ClassOutside/Rotate_Camera_By_Mouse_Movement
	//
	// ╭━━╮╱╱╱╱╭╮╱╱╱╱╱╭╮╱╭╮╱╱╱╱╱╭╮            ━╮ ╭━
	// ╰┫┣╯╱╱╱╱┃┃╱╱╱╱╭╯╰╮┃┃╱╱╱╱╱┃┃             | |
	// ╱┃┃╭━╮╭━╯┣━━┳━┻╮╭╯┃┃╱╱╭━━┫╰━┳━━╮       ╱ o \
	// ╱┃┃┃╭╮┫╭╮┃┃━┫━━┫┃╱┃┃╱╭┫╭╮┃╭╮┃━━┫      ╱_____\
	// ╭┫┣┫┃┃┃╰╯┃┃━╋━━┃╰╮┃╰━╯┃╭╮┃╰╯┣━━┃     ╱    o  \
	// ╰━━┻╯╰┻━━┻━━┻━━┻━╯╰━━━┻╯╰┻━━┻━━╯    (__o______)

	// Yet another science experiment from Indest Labs.

	// Recommend viewing in Visual Source Code.
	//
	import { T, useThrelte } from '@threlte/core'
	import { OrbitControls, useTexture, Float, Audio, AudioListener } from '@threlte/extras'
	import { Vector2, Vector3, Raycaster } from 'three'
	import * as THREE from 'three'

	import { onMount } from 'svelte'

	import Eye from '$components/Eye.svelte'
	import Skull from './Skull.svelte'

	let leftEye: any
	let rightEye: any

	const { camera } = useThrelte()

	const textures = useTexture('/eyeball.jpg')

	onMount(() => {
		const plane = new THREE.Plane()

		let planeNormal = new THREE.Vector3()
		let planePoint = new THREE.Vector3()
		const pointer = new Vector2() // mouse or finger? Not liking how it works on iPhone
		const raycaster = new Raycaster()
		const lookAt = new THREE.Vector3(1.0, 1.45, 3.5)

		window.addEventListener('pointermove', onPointerMove)

		// a function to be called every time the mouse/pointer moves
		function onPointerMove(event: any) {
			// normalize space to -1, -1 -> 1, 1 square

			pointer.x = (event.clientX / window.innerWidth) * 2 - 1
			pointer.y = -(event.clientY / window.innerHeight) * 2 + 1

			raycaster.setFromCamera(pointer, $camera)

			$camera.getWorldDirection(planeNormal)
			planePoint.copy(planeNormal).setLength(6).add($camera.position) // its always 6...6, why 6?
			plane.setFromNormalAndCoplanarPoint(planeNormal, planePoint)

			raycaster.ray.intersectPlane(plane, lookAt)
			leftEye.lookAt(lookAt)
			rightEye.lookAt(lookAt)
		}
		return () => {
			window.removeEventListener('pointermove', onPointerMove)
		}
	})
</script>

// spoookiness
<Float rotationIntensity={0.75} rotationSpeed={3}>
	// camera // Need to go back to algebra class and stay awake this time

	<T.PerspectiveCamera makeDefault position={[3, 5, 8]} fov={45}>
		<OrbitControls
			enableZoom={false}
			enableDamping
			target.y={0.0}
			minPolarAngle={Math.PI / 8}
			maxPolarAngle={Math.PI / 2}
			minAzimuthAngle={-Math.PI / 3}
			maxAzimuthAngle={Math.PI / 1.5}
		/>
	</T.PerspectiveCamera>
</Float>

// light, just a hint of moonlight off of the skull from the upper left
<T.DirectionalLight intensity={0.8} position.x={-15} position.y={30} />

<T.AmbientLight intensity={0.2} />

// wait for it
{#await textures then texture}
	// skull & eyes
	<T.Group>
		<Skull />
		<Eye bind:reference={leftEye} {texture} position={[-1.86, -1.7, -0.7]} />
		<Eye bind:reference={rightEye} {texture} position={[-0.65, -1.65, -1.4]} />
	</T.Group>
{/await}
