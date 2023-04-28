# SatFinder
Final Project for a Swift college course. Deleted and reuploaded due to sensitive information in old repo

TLE = Two-Line Element of a satellite. The standard protocol for storing information about a satellite as numbers and letters.

The Xcode Project itself follows the MVVM design pattern. Files within the project are organized as follows:
    - Models:
        - Satellite: A struct that contains the values decoded from the TLE of a satellite
        - RawSatellite: A struct that contains a satellite's name and NORAD ID
        - LocationSatellite: A struct that contains a satellite's latitude, longitude, and altitude
        - Country: A struct representing a country/organization containing an array of satellite ids belonging to it
    - ViewModels:
        - SatelliteViewModel: A file that parses the local JSON of active satellites and populates an array with RawSatellite objects
        - DetailViewModel: A file that uses a satellite's NORAD ID to call an API and fetch that satellite's TLE, then decode it and create a Satellite object from the info
        - LocationViewModel: A file that uses a satellite's NORAD ID to call an API and fetch that satellite's location information.
        - CountriesViewModel: A file that parses the local JSON of countries/organizations and populates an array with Country objects
    - Views:
        - Launch Screen: The launch screen to be displayed upon startup.
        - ListView: The main view of the app. Upon loading of the NavigationStack the SatelliteViewModel's getRawData method is called, and the satellitesArray is used to populate the list
        - DetailView: Upon tapping on a satellite in the list, the user is directed to a view containing information about the satellite. TLE info is fetched and decoded here as opposed to doing so for all satellites upon startup
        - LocationView: A view which is displayed as the lower half of the DetailView. Calls the API and returns location information for a satellite, then creates a MapView. Also contains an update location button to refetch data
        - MapView: The view which displays the current location of a satellite as a blue circle.

satellites_by_country: A JSON created from scraping N2YO's website. This contains an array of objects with the name, code, and an array of satellite IDs belonging to a country or organization
active_satellites: A JSON created from restructuring JSONs downloaded from CelesTrak. An Array of objects containing the name and ID of a satellite

The two above JSONs should be added to the Xcode project to make the app work properly
All JSON data is either fetched from N2YO.com (which requires an API Key) or downloaded in JSON format from CelesTrak.org (which is also where N2YO gets its data).
Files in the Additional Files folder were updated as of April 27, 2023 and therefore may not be accurate in the future.

Additional Files:
    - JSONs: A folder containing all the raw JSONs downloaded from CelesTrak
    - JSONEditor.py: A python script that parses through all JSON files downloaded from CelesTrak and creates the active_satellites JSON for use in the project
        - NOTE: CelesTrak's active satellites JSON included almost all of the satellites from the other files, however there were 255 not found in this file that were found in others
    - launchscreen/logo: Self explanatory, the launchscreen and logo I used for the project. The launchscreen was created by myself in gimp, using images from the internet. The logo is from the internet as well
    - SatelliteCountryScraper: An R script (in Quarto Doc and pdf format) Used to scrape N2YO's website and create a JSON of countries/organizations and the satellites (by ID) they currently own
        - NOTE: I only needed to create this file because I could not find an API offering this information. N2YO may create an API for this purpose in the future though, so it may become unnecessary
    
