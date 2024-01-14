### README

# Odin – advanced forms project – Flight Booker

- A flight search app featuring complex forms touching multiple models
- Models; User, Flight, Airport, Search, Booking
- Uses Devise
- CSV parsing class to parse imported airport data to seed the db

---

### Airline booking flow:

1. Enter desired dates / airports and click “Search”
2. Choose from among a list of available flights
3. Enter passenger information for all passengers
4. Enter billing information (via integration of something like Paypal, via a gem or an SDK or Stripe.)


### ToDos:

- Introduce logic to calculate real distance between airport locations then calculate travel time therefore departure time
- 