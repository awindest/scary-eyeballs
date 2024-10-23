// Eye.svelte
<script lang='ts'>
    import { T } from '@threlte/core'

    import fragmentShader from '$lib/shaders/fragment.glsl?raw' // the ?raw is a Vite directive to include all as string
    import vertexShader from '$lib/shaders/vertex.glsl?raw'

    export let position:number[]
    export let reference:any
    export let texture

</script>
<!-- reference values are either 'leftEye' or 'rightEye' -->
<T.Mesh
  position={position}
  bind:ref={reference}
>
  <T.SphereGeometry args={[.45, 64, 32]} />
  <T.MeshMatcapMaterial map={texture}  />

  <T.ShaderMaterial 
    {fragmentShader} 
    {vertexShader} 
    uniforms={{
      tex: {value: texture}
    }}
  />
</T.Mesh>