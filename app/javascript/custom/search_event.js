document.addEventListener('keydown', e => {
  if (e.code == 'Enter' && document.activeElement == document.getElementById('search-event-input')) {
      window.location.href = '/events/?q=' + document.getElementById('search-event-input').value;
  }
});