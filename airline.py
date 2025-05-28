import mysql.connector

# Establish database connection
cnx = mysql.connector.connect(
    user='root',
    password='password',  # Replace with your MySQL password
    host='localhost',
    database='airline'
)
cursor = cnx.cursor()

# Main menu template
def show_menu():
    print('-' * 55)
    print('|     Welcome To India Airlines Reservation Portal     |')
    print('-' * 55)
    print('| A. Search Flights                                    |')
    print('| B. Reservation Enquiry                              |')
    print('| C. Book Ticket                                       |')
    print('| E. Exit                                              |')
    print('-' * 55)

# Search for flights
def search_flights():
    origin = input("Enter the origin: ")
    destination = input("Enter the destination: ")
    departure_date = input("Enter departure date (YYYY-MM-DD): ")

    query = """
        SELECT flight_id, airline, origin, destination, departure_time, arrival_time, price
        FROM flights
        WHERE origin = %s AND destination = %s AND departure_time >= %s
    """
    cursor.execute(query, (origin, destination, departure_date))
    flights = cursor.fetchall()

    if flights:
        print("\nAvailable Flights:")
        for flight in flights:
            print(f"Flight ID: {flight[0]}")
            print(f"Airline: {flight[1]}")
            print(f"From: {flight[2]} To: {flight[3]}")
            print(f"Departure: {flight[4]}, Arrival: {flight[5]}")
            print(f"Price: ₹{flight[6]}\n")
    else:
        print("No flights found.\n")

# Check available seats
def check_reservations():
    flight_id = input("Enter Flight ID to check seats: ")

    query = """
        SELECT seat_number FROM seats
        WHERE flight_id = %s AND status = 'available'
    """
    cursor.execute(query, (flight_id,))
    seats = cursor.fetchall()

    if seats:
        print("\nAvailable Seats:")
        for seat in seats:
            print(seat[0])
    else:
        print("No available seats found.")

# Book a ticket
def book_ticket():
    flight_id = input("Enter Flight ID: ")
    customer_name = input("Enter your name: ")
    seat_number = input("Enter seat number to reserve: ")

    query = "SELECT status FROM seats WHERE flight_id = %s AND seat_number = %s"
    cursor.execute(query, (flight_id, seat_number))
    result = cursor.fetchone()

    if result is None:
        print("Seat not found.")
        return

    seat_status = result[0]
    if seat_status != "available":
        print("Sorry, the seat is not available.")
        return

    insert_query = """
        INSERT INTO reservations (flight_id, customer_name, seat_number, reservation_time)
        VALUES (%s, %s, %s, NOW())
    """
    cursor.execute(insert_query, (flight_id, customer_name, seat_number))

    update_query = """
        UPDATE seats SET status = 'reserved'
        WHERE flight_id = %s AND seat_number = %s
    """
    cursor.execute(update_query, (flight_id, seat_number))

    cnx.commit()
    print("Reservation created successfully!\n")

# Main loop
def main():
    while True:
        show_menu()
        choice = input("Enter your choice (A/B/C/E): ").strip().upper()

        if choice == 'A':
            search_flights()
        elif choice == 'B':
            check_reservations()
        elif choice == 'C':
            book_ticket()
        elif choice == 'E':
            print("Thank you for using India Airlines Reservation System.")
            break
        else:
            print("Invalid choice. Please try again.\n")

# Run the application
try:
    main()
finally:
    cursor.close()
    cnx.close()