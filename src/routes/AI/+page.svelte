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

.drab-dark-brown-2 {
  color: #594e36; 
}


.logo-image {
  display: block;
  width: 40vw;       
  max-width: 400px;  
  height: auto;
  margin: 0 auto;
}

@media (max-width: 768px) {
  .logo-image {
    width: 70vw;     
    max-width: 300px;
    max-height: 20vh;
  }
}

@media (max-width: 480px) {
  .logo-image {
    width: 85vw;     
    max-width: 260px;
  }
}

.trash-wrapper {
  position: fixed;      
  bottom: 0;            
  left: 50%;           
  transform: translateX(-50%) rotate(0deg);
  width: 100%;            
  text-align: center;
  z-index: 0;           
  margin: 0;        
  pointer-events: none;
}

.trash-wrapper img {
  width: 100%;          
  height: auto;
  display: block;
}

@media (max-width: 768px) {
  .trash-wrapper {
    height: auto; 
  }
}

@media (max-width: 480px) {
  .trash-wrapper {
    display: none;
    display: none;
  }
}

.made_with_heart {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background: transparent;
  text-align: center;
  padding: 3rem 0;
  z-index: 10;
  margin-top: 0 !important;
  line-height: 4;
}

/* @media (max-width: 768px) {
  .made_with_heart {
    margin-top: 0
    font-size: 0.9rem;
    flex-direction: column;
  }
} */

@media (max-width: 375px) {
  .made_with_heart {
    display: none;
    display: none;
  }
}

@media (max-width: 768px) {
  .names {
    margin-left: 0.4vw !important;  
    margin-right: 0.4vw !important;
  }
  .y_tag {
    margin-right: 0.4vw !important;  
  }
}

body {
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
}

img {
  position: relative;
  z-index: -1; 
}


</style>


<script>
  import { onMount } from "svelte";

  let responseText = "";

  async function sendMessage() {
    const url = "https://ai.hackclub.com/chat/completions";

    const body = {
      messages: [{ role: "system", content: "You are an ai idea generator for the hackclub ysws clutter. Please give the user clear concise ideas for tools, websites, or application that declutter the user's day to day life. Please respond with one idea formatted as just the idea.  Please don't include a name for the application, be sure to make useful. Make the output less than 15 words. Please dont include any special characters like \\\"\\\" or <>." }],
      model: "qwen/qwen3-32b"
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

<div style="background-color: #594e36; min-height: 100vh; padding: 2%">
  <p class="rounded-lg inline-block" style="text-decoration: none; display: block; width: 100%; line-height: 1.1; color: white; font-size: 1.5rem;">
    {#if responseText}
      {responseText}
    {:else}
      Loading...
    {/if}
  </p>
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
