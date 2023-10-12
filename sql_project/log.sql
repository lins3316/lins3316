-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports WHERE day = 28 AND month = 7 AND street = 'Humphrey Street'; -- Get a descripton of the crime
SELECT transcript FROM interviews WHERE day = 28 AND month = 7 AND transcript LIKE '%bakery%'; -- Look at the transcripts from the interviews

-- Analyze the first interviewee's clues
SELECT name FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 AND month = 7 AND hour = 10 AND minute > 15 AND minute < 25); -- linked the found license plates to the vehicle owners

-- Analyze the second witness's clues
SELECT name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day = 28 AND month = 7 AND year = 2021 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw');

-- Analyze the third witness clues
SELECT name FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60);
-- check my list of passengers in the earliest flight
SELECT name FROM people WHERE passport_number IN
(SELECT passport_number FROM passengers JOIN flights ON passengers.flight_id = flights.id JOIN airports ON airports.id = flights.origin_airport_id
WHERE day = 29 AND year = 2021 AND month = 7 AND full_name LIKE '%Fiftyville%' ORDER BY hour ASC, minute ASC);

-- Reduce my list of suspects
SELECT name FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60)
INTERSECT
SELECT name FROM people WHERE license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 AND month = 7 AND hour = 10 AND minute > 15 AND minute < 25)
INTERSECT
SELECT name FROM people JOIN bank_accounts ON people.id = bank_accounts.person_id WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day = 28 AND month = 7 AND year = 2021 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
INTERSECT
SELECT name FROM people WHERE passport_number IN
(SELECT passport_number FROM passengers JOIN flights ON passengers.flight_id = flights.id JOIN airports ON airports.id = flights.origin_airport_id
WHERE day = 29 AND year = 2021 AND month = 7 AND hour = 8 AND minute = 20 AND full_name LIKE '%Fiftyville%' ORDER BY hour ASC, minute ASC);

-- look for the city the thief escaped to
SELECT city FROM airports
JOIN flights ON flights.destination_airport_id = airports.id
JOIN passengers ON flights.id = passengers.flight_id
JOIN people ON people.passport_number = passengers.passport_number
WHERE name = 'Bruce';

-- look for the accomplice
SELECT name FROM people
JOIN phone_calls ON phone_calls.receiver = people.phone_number
WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND caller = (SELECT phone_number FROM people WHERE name = 'Bruce');