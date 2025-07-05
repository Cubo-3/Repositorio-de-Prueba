
  function toggleMode() {
    document.body.classList.toggle('light-mode');

    const btn = document.getElementById('toggle-btn');
    btn.textContent = document.body.classList.contains('light-mode') ? '🌙' : '☀️';
  }

