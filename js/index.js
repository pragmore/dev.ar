const wait = 1500;
const container = document.querySelector('h1 em');
const typewriter = new Typewriter(container, {
  loop: true
});
const match = window.location.search.match('from=([^&]+)');
const texts = ['tunombre', 'mitienda', 'loquesea'];
if (match) {
  texts.unshift(match[1])
}
for (text of texts) {
  typewriter.typeString(text)
    .pauseFor(wait)
    .deleteAll();
}
typewriter.start();
