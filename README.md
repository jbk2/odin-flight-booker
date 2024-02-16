# README

## The Odin Project – RoR Advanced Forms Project – Flight Booker
_with significantly extended features_

---

### Summary
A flight search app featuring
- Complex forms; nesting, custom actions, hotwire.
- Advanced modeling & associations; m2m, polymorphic, delegation, custom validation, callbacks.
- Custom Devise authentication - on passengers, with conditional requirements ending user type.
- POROs - custom CSV parsing, data cleaning and merging and db seeding.
- SPA like - Turbo Frames, Streams & Stimulus serving dynamic flight search form and results
- Styling - TailwindCSS use & customisation of.


### Rspec Tested
_Utilising Rspec, FactoryBot, Capybara, Selenium_

- Unit tested
  - All models.
  - PassengerMailer.
  - PassengerFlightReminderJob.

- Request tested
  - airports, bookings, flights.

- System tested
  - end to end flight search > results > booking > passenger creation > booking confirmation process.

---

### Further ToDos:

- Validations
  - duplication of airports in flight search form - front & back.
  - duplication of passengers in booking form - front & back.
  - flights can't be searched, or booked, with same arrival and departure airports.

- Features
  - Google distance API to calc real distance between airport locations.
  - Advanced seed logic
    - ensure arrival airport != departure airport.
    - flight > x distance/duration.
    - balance seed generation between locations, not just random.

- UI
  - Overall UI thematic imrovement.
  - flipboard like UI elements?
  - animated polaroid holiday picture elements in background.
  - nice input field rings with label over top.
  - Nicer date picker - populated with only flight available dates (not juts min & max).
  - Flight search input field - keypress search match.
