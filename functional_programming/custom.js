
      Reveal.initialize({
        controls: true,
        progress: true,
        history: true,
        center: false,
        theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
        transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none

        // Optional libraries used to extend on reveal.js
        dependencies: [
          { src: 'reveal.js/lib/js/classList.js', condition: function() { return !document.body.classList; } },
          { src: 'reveal.js/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
          { src: 'reveal.js/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } },
//          { src: 'reveal.js/plugin/search/search.js', async: true, condition: function() { return !!document.body.classList; }, }
//          { src: 'reveal.js/plugin/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
]});
