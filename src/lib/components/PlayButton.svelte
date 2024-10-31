<script lang="ts">
	import { onMount } from 'svelte';
	let fugue: HTMLAudioElement;
	let isPlaying: boolean = false;
	let buttonText = 'Play Bach Fugue';
	onMount(() => {
		loadFugue();
	});

	function onToggle() {
		isPlaying = !isPlaying;
		// console.log(isPlaying)
		if (!fugue) {
			loadFugue();
		}
		if (isPlaying) {
			playFugue();
			fugue.onended = () => {
				buttonText = 'Play Bach Fugue';
				isPlaying = !isPlaying;
			};
		} else {
			pauseFugue();
		}
		buttonText = isPlaying ? 'Pause Bach Fugue' : 'Play Bach Fugue';
	}
	function loadFugue() {
		fugue = new Audio('/bach-toccata-and-fugue-in-d-minor.m4a');
	}
	function playFugue() {
		fugue.play();
	}
	function pauseFugue() {
		fugue.pause();
	}

	// loadFugue()
</script>

<span id="buttonOnBottom">
	<button
		on:click={onToggle}
		title="Play some spooky music; but before you do, check your volume level."
	>
		{buttonText}
	</button>
</span>

<style>
	#buttonOnBottom {
		position: absolute;
		bottom: 2.5rem;
		width: 100%;
		text-align: center;
	}

	button {
		color: rgba(238, 14, 96, 1);
		background: transparent;
		outline: 1px solid rgba(238, 14, 96, 0.75);
		border-radius: 0.5rem;
		border: 0px;
		padding: 5px 10px;
		cursor: pointer;
	}

	button:hover {
		background-color: rgba(238, 14, 96, 0.45);
	}
</style>
