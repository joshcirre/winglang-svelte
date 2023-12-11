<script lang="ts">
    import { onMount } from 'svelte';

    let count: number = 0;
    let fromServer = window.wingEnv['fromServer'];
    let serverUrl = window.wingEnv['APP_SERVER_URL'];
    let isFetching = false;

    const increment = async () => {
        count += 1;
        isFetching = true;
        await incrementServerCount();
        isFetching = false;
    }

    const getServerCountRandom = async () => {
        isFetching = true;
        const res = await fetch(`${serverUrl}/api/random`);
        const data = await res.json();
        count = data;
        console.log(count);
        isFetching = false;
    }

    const resetCount = async () => {
        count = 0;
        isFetching = true;
        await resetServerCount();
        isFetching = false;
    }

    const incrementServerCount = async () => {
        isFetching = true;
        const res = await fetch(`${serverUrl}/api/counter`);
        const data = await res.json();
        count = data;
        console.log(count);
        isFetching = false;
    }

    const getServerCount = async () => {
        isFetching = true;
        const res = await fetch(`${serverUrl}/api/getcount`);
        const data = await res.json();
        count = data;
        console.log(count);
        isFetching = false;
    }

    const resetServerCount = async () => {
        isFetching = true;
        const res = await fetch(`${serverUrl}/api/reset`);
        const data = await res.json();
        count = data;
        console.log(count);
        isFetching = false;
    }

    onMount(() => {
        getServerCount();
    });
</script>

<button on:click={increment} disabled={isFetching}>
  count is {count}
</button>
<p>{fromServer}</p>
<button on:click={getServerCountRandom} disabled={isFetching}>
  Roll the Dice 🎲
</button>
<button on:click={resetCount} disabled={isFetching}>
  Reset Count
</button>
