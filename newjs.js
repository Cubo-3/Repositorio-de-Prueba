
  function toggleMode() {
    document.body.classList.toggle('light-mode');

    const btn = document.getElementById('toggle-btn');
    btn.textContent = document.body.classList.contains('light-mode') ? '🌙' : '☀️';
  }


document.addEventListener("DOMContentLoaded", () => {
  const imagenes = [
    "img/fondo.jpg",
    "img/fondo1.jpg",
  ];

  let index = 0;
  let active = true; // controla qué capa está activa

  const bg1 = document.querySelector('.hero-bg1');
  const bg2 = document.querySelector('.hero-bg2');

  // Pre-cargar imágenes
  imagenes.forEach(src => {
    const img = new Image();
    img.src = src;
  });

  setInterval(() => {
    index = (index + 1) % imagenes.length;
    const nuevaImagen = imagenes[index];

    if (active) {
      bg2.style.backgroundImage = `url('${nuevaImagen}')`;
      bg2.style.opacity = 1;
      bg1.style.opacity = 0;
    } else {
      bg1.style.backgroundImage = `url('${nuevaImagen}')`;
      bg1.style.opacity = 1;
      bg2.style.opacity = 0;
    }

    active = !active;
  }, 3000);
});
