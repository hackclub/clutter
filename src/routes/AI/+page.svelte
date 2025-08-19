<svelte:head>
  <title>Clutter - YSWS</title>
  <link rel="icon" type="image/png" href="/favicon.png" />

  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css2?family=Londrina+Shadow&family=Orbitron:wght@400;900&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Londrina+Shadow&family=Nata+Sans:wght@100..900&family=Orbitron:wght@400..900&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap" rel="stylesheet" />

</svelte:head>

<style>
@import url('https://fonts.googleapis.com/css2?family=Londrina+Shadow&family=Nata+Sans:wght@100..900&family=Orbitron:wght@400..900&display=swap');

.handwritten {
  font-family: "Permanent Marker";
  font-weight: 400;
  font-style: normal;
}

.handwritten-big {
  font-family: "Permanent Marker";
  font-weight: 500;
  font-style: normal;
}

</style>


<script>
  import { onMount } from "svelte";

  let responseText = "";

  async function sendMessage() {
    const url = "https://ai.hackclub.com/chat/completions";

    const body = {
      messages: [{ role: "system", content: "You are an AI idea generator for Hack Club YSWS Clutter give one simple useful and doable tool website or app idea under 15 words without a name or special characters." }],
      model: "openai/gpt-oss-20b"
    };

    try {
      const res = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(body)
      });

      if (!res.ok) {
        throw new Error(`HTTP error! status: ${res.status}`);
      }

      const data = await res.json();
      console.log(data); // full response
      responseText = data.choices?.[0]?.message?.content || JSON.stringify(data);
      responseText = (data.choices?.[0]?.message?.content || "")
                  .replace(/<think>.*?<\/think>/gs, "");
    } catch (err) {
      console.error("Error sending request:", err);
      // @ts-ignore
      responseText = "Error: " + err.message;
    }
  }

  onMount(() => {
    sendMessage();
  });
  async function reload_tab() {
    location.reload()
  }
</script>

<div style="background-color: #594e36; min-height: 100vh; padding: 2%;">
  <!-- <div class="center"> DOES NOT WORK -->
    <p class="handwritten rounded-lg inline-block" style="text-decoration: none; display: block; width: 100%; line-height: 1.1; color: white; font-size: 1.5rem;">
      {#if responseText}
        {responseText}
      {:else}
        Loading...
      {/if}
    </p>
  <!-- </div> DOES NOT WORK -->
  <br>
  <!-- <a href="/" style="background-color: white; color: #594E36;" class="handwritten-big p-4 rounded hover:scale-105 inline: block; text-decoration: none; margin-right: 1rem;">Main Site</a> -->
  <div style="display: flex; gap: 0.5rem;">
    <button on:click={() => window.location.href = "/"} style="background-color: white; color: #594E36;" class="handwritten-big p-3 rounded hover:scale-105 text-decoration: none; margin-right: 5vw;">
      Main Site
    </button>
    <button on:click={reload_tab} style="background-color: white; color: #594E36;" class="handwritten-big p-3 rounded hover:scale-105 cursor: pointer;">
      New Idea
    </button>
  </div>
</div>
