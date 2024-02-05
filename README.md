### README

# Odin – advanced forms project – Flight Booker

- A flight search app featuring complex forms touching multiple models
- Models; User, Flight, Airport, Booking, Passenger
- A CSV parseing class to parse and merge multiple source airport data to seed the db
- Dynamic flight search form using Stimulus and Turbo streams to:
  - dynamically populate airport select inputs from selected country and date select input based upon available flights
  - load flight results all on Flights#index/flights_path
- Use of TailwindCSS for styling

---

### Learnings / Further practie on:

- Turbo Frames, Streams & Stimulus - general SPA tactics in Rails
- jQuery play
- Further model association
- Complex nested forms

---

### ToDos:

- Build sign up modal for bookings new page. 
- stop flight search form width changing
- Passenger validations, front & back:
  - duplication in single form
  - if email present in db already link booking passenger to the record already in db.
- Create My account & My Bookings pages
- Introduce logic so that flights can't be searched, or booked, with same arrival and departure airports
- Introduce logic to calculate real distance between airport locations then calculate travel time therefore departure time (APIs; Google distance)
- model validation
- Advance seed logic - ensure flights do not arriva at same departure location, are no shorter than x distance, logic to balance flight seed generation between locations.
- Build nicer UI (flipboard UI perhaps, animated polaroid holiday picture elements in background)
- implement flight search date picker populated with only flight available dates
