https://www.getpostman.com/collections/4dec2f34dc2e78c249b9

Do the following:

-   cd api
-   create .env inside api folder and copy paste example.env and fill values
-   npm i
-   npm start

1. Book Now

-   http://localhost:5000/api/booking
-   {
    "email":"321@gmail.com",
    "facilityId":1,
    "startDateTime":600
    }

    Cannot cancel bookings

2. Profile Page

-   most frequent sport played ( show this )
-   active days history with date user can see which sport(s) he played on that day
-   add badge if 30 days

3. Individual Sport Page

-   when is the most crowded time
-   number of courts
-   on confirmation it will show the court number which is assigned

*   NOTES:

-   when you register in swift using firebase just call /register and pass all details in body (firstName, lastName, email, contactNumber)
-   always pass emailid of loggedin user in request body
-   send date from frontend as a number converted to seconds
    (startDateTime)
