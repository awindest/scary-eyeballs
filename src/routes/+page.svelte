<script lang="ts">
  import App from '$lib/components/App.svelte'
  import IndestLabs from '$lib/components/IndestLabs.svelte'
  import PlayButton from '$lib/components/PlayButton.svelte'

</script>

<div>
  <App />
  <IndestLabs />
  <PlayButton />

</div>

<style>
  :global(body) {
    margin: 0;
    background-image: url("/haunted-house.jpg");
      /* Center and scale the image nicely */
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    background-color: rgba(200,100,0,.5);
    background-blend-mode: multiply; /* played around with the parameters until I saw something I liked */
  
    cursor: url('/Skeleton+Hand+Cursor.png'), auto;
    overflow: hidden;
  }

  div {
    width: 100vw;
    height: 100vh;
  }
</style>
