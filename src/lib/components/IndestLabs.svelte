<!--                                  
╭━━╮╱╱╱╱╭╮╱╱╱╱╱╭╮╱╭╮╱╱╱╱╱╭╮            ━╮ ╭━
╰┫┣╯╱╱╱╱┃┃╱╱╱╱╭╯╰╮┃┃╱╱╱╱╱┃┃             | |
╱┃┃╭━╮╭━╯┣━━┳━┻╮╭╯┃┃╱╱╭━━┫╰━┳━━╮       ╱ o \
╱┃┃┃╭╮┫╭╮┃┃━┫━━┫┃╱┃┃╱╭┫╭╮┃╭╮┃━━┫      ╱_____\
╭┫┣┫┃┃┃╰╯┃┃━╋━━┃╰╮┃╰━╯┃╭╮┃╰╯┣━━┃     ╱    o  \  
╰━━┻╯╰┻━━┻━━┻━━┻━╯╰━━━┻╯╰┻━━┻━━╯    (__o______)  

Yet another science experiment from Indest Labs.

Recommend viewing in Visual Source Code.
-->
<script>
	import { fade, fly } from 'svelte/transition';
	import { onMount } from 'svelte';
	let animateLabsLogo = false;

	onMount(() => {
		animateLabsLogo = true;
	});
</script>

{#if animateLabsLogo}
	<div transition:fly={{ y: 10, delay: 1000, duration: 2500 }} id="labs">
		<a
			href="https://github.com/awindest/scary-eyeballs"
			title="Click to see the source code on github."
		>
			Indest Labs
			<img
				style="float:right;height:2.5em;filter:contrast(75%);"
				src="flask.svg"
				alt="Laboratory Flask"
			/>
		</a>
	</div>
{/if}

<style>
	/* author's stamp */
	#labs {
		position: absolute;
		z-index: 10;
		bottom: 0;
		margin-left: 0.5rem;
		margin-bottom: 0.5rem;
		background: transparent;
		color: #042e64;
		font-size: 9px;
		font-family: sans-serif;
		text-shadow:
			-1px -1px 2px #fff,
			-1px 1px 2px #fff,
			1px -1px 2px #fff,
			1px 1px 2px #fff;
	}
	a:hover {
		text-shadow: 0 0 5px #ff0000;
		color: white;
	}
	a:before {
		content: '';
		background: rgba(238, 14, 96, 0.75);
		position: absolute;
		top: -2px;
		left: -2px;
		-webkit-background-size: 400%;
		background-size: 400%;
		z-index: -1;
		filter: blur(5px);
		width: calc(100% + 4px);
		height: calc(100% + 4px);
		opacity: 0;
		transition: opacity 0.5s ease;
	}
	/* get rid of the hyperlink underline for all states */
	a:hover:before {
		opacity: 0.75;
		color: white;
	}
	a:link {
		text-decoration: none;
	}
	a:visited {
		text-decoration: none;
	}
	a:hover {
		text-decoration: none;
	}
	a:active {
		text-decoration: none;
	}
</style>
