<script lang="ts">
  // follow the eyes: https://github.com/ClassOutside/Rotate_Camera_By_Mouse_Movement

  import { T, useThrelte } from '@threlte/core'
  import { OrbitControls, useTexture, Float, Audio, AudioListener } from '@threlte/extras'
  import { Vector2, Vector3, Raycaster} from 'three'
  import * as THREE from 'three'

	import { onMount } from 'svelte';

  import Eye from '$components/Eye.svelte'
  import HumanSkull from './human_skull.svelte';

  let leftEye:any
  let rightEye:any

  const { camera } = useThrelte()

  const textures = useTexture('/eyeball.jpg')
   
onMount( () => {

  const plane = new THREE.Plane()

  let planeNormal = new THREE.Vector3()
  let planePoint = new THREE.Vector3()
  const pointer = new Vector2() // mouse or finger?    
  const raycaster = new Raycaster()
  const lookAt = new THREE.Vector3(1.0, 1.45, 3.5)


  window.addEventListener('pointermove', onPointerMove) 

// //A function to be called every time the mouse/pointer moves
  function onPointerMove(event : any) { // normalize space to -1, -1 -> 1, 1 square
    
    pointer.x =  (event.clientX / window.innerWidth) * 2 - 1
    pointer.y = -(event.clientY / window.innerHeight) * 2 + 1
    
    raycaster.setFromCamera(pointer, $camera)
    
    $camera.getWorldDirection(planeNormal)
    planePoint.copy(planeNormal).setLength(6).add($camera.position)
    plane.setFromNormalAndCoplanarPoint(planeNormal, planePoint)

    raycaster.ray.intersectPlane(plane, lookAt)
    leftEye.lookAt(lookAt)
    rightEye.lookAt(lookAt)
 

  }
    return () => {
      window.removeEventListener('pointermove', onPointerMove)
    }

  })

  function playAudio() {
    // create an AudioListener and add it to the camera

    const listener = new THREE.AudioListener();
    $camera.add( listener );
    // create a global audio source
    const sound = new THREE.Audio( listener );

    // load a sound and set it as the Audio object's buffer
    const audioLoader = new THREE.AudioLoader();
    audioLoader.load( '/bach-toccata-and-fugue-in-d-minor.m4a', function( buffer ) {
      sound.setBuffer( buffer );
      sound.setLoop( true );
      sound.setVolume( 0.5 );
      sound.play();
    })
}
function playMe() {
  console.log('playMe clicked')
}

</script>
<span id='buttonOnBottom'>
  <button on:click={playMe}>
    Play Bach Fugue
  </button>
</span>

// spoookiness
<Float
  rotationIntensity={0.75}
  rotationSpeed={3}
>
// camera
  <T.PerspectiveCamera
    makeDefault
    position={[3, 5, 8]}
    fov={45}
  >
    <OrbitControls
      enableZoom={false}
      enableDamping
      target.y={0.0}
      minPolarAngle={Math.PI/8}
      maxPolarAngle={Math.PI/2}
      minAzimuthAngle={-Math.PI/3}
      maxAzimuthAngle={Math.PI/1.5}
    />

  </T.PerspectiveCamera>
</Float>

// light
<T.DirectionalLight
  intensity={0.8}
  position.x={5}
  position.y={10}
  />

<T.AmbientLight intensity={0.2} />

// wait for it
{#await textures then texture}
  // eyes
  <T.Group>
    <Eye bind:reference={leftEye} texture={texture}  position={[-1.86, -1.7, -.7]}/>
    <Eye bind:reference={rightEye} texture={texture}  position={[-.65,-1.65, -1.4]} />
    <HumanSkull />
  </T.Group>

{/await} 



<style>
   #buttonOnBottom {
        position: absolute;
        bottom: 2.5rem;
        width: 100%;
        text-align: center;
    }
   
    button {
        color: rgba(238, 14, 96, 1.0);
        background: transparent;
        outline: 1px solid rgba(238, 14, 96, 0.75);
        border-radius: .5rem;
        border: 0px;
        padding: 5px 10px;
        cursor: pointer;
    }

    button:hover {
        background-color: rgba(238, 14, 96, .45);
    }

</style>