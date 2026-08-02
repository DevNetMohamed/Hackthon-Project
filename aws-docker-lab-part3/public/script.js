const dateElement = document.getElementById('current-date');

const formattedDate = new Intl.DateTimeFormat('en-GB', {
  weekday: 'long',
  day: '2-digit',
  month: 'long',
  year: 'numeric'
}).format(new Date());

dateElement.textContent = formattedDate;
