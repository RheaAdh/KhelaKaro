https://www.getpostman.com/collections/4dec2f34dc2e78c249b9

Do the following:

-   cd api
-   create .env inside api folder and copy paste example.env and fill values
-   npm i
-   npm start

1. Book Now

-   show err message coming backend as a popup

2. Profile Page

-   frequency of each sport played ( show max min whatever )
-   for each sport show history of dates he played

3. Individual Sport Page

-   number of courts
-   on confirmation it will show the court number which is assigned

*   NOTES:

-   when you register in swift using firebase just call /register and pass all details in body (firstName, lastName, email, contactNumber)
-   always pass emailid of loggedin user in request body
-   always Post request
-   send date from frontend in this format "July 1, 1978 02:30:00"

---

THINGS TODO

1. register user populate mongo atlas
2. Profile ui

-   frequency of each sport played ( show max min whatever )
-   active days history with date user can see which sport(s) he played on that day

3. Integrate frontend and backend fully

POST http://localhost:5000/api/auth/register

{
"firstName":"Rhea",
"lastName":"Adhikari",
"email":"rheadhikari@gmail.com",
"contactNumber":9999999999
}

POST http://localhost:5000/api/stats/freqencySport

{
"email":"rheadhikari@gmail.com"
}

Booking

-   POST http://localhost:5000/api/booking
-   {
    "email":"321@gmail.com",
    "facilityId":1,
    "startDateTime":600
    }
