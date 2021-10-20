# corona

Covid 19 Tracker
![WhatsApp Image 2021-10-20 at 10 11 06 PM](https://user-images.githubusercontent.com/85360095/138164809-839406d7-935a-4e3d-8501-53fd9c5347a7.jpeg)

![WhatsApp Image 2021-10-20 at 10 11 07 PM](https://user-images.githubusercontent.com/85360095/138164840-d60b34fa-9a98-499f-b927-a1f52ff5e531.jpeg)


## Use Cases:
- Creating a map of the world
- Showing red points of infections on the map
- clicking on the country and showing it's details
- put all the data required on the details screen



https://user-images.githubusercontent.com/85360095/138164515-13d441ed-8ecc-48a9-9c3d-1c9689594917.mp4



## Clean Architicture:
- Presentation & Data
- State Managment ( Bloc - Cubit )

## Using Google map:
- Using Circles on the map 
- Using Google Map Api
## Get Data from https://coronavirus-tracker-api.herokuapp.com/v2/locations:
- using a map of countries code to get the data by code and showing its counrty
- using map instead of list increase the performance 
- used the Lat. and Longt. with the infection data to draw a red circle of the most infected countries

- used const in constants variablesand other methods to increase performance
- didn't used future builder to catch data because of its bad performance

