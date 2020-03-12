# infection-tracking and geotemporal encoding

## problem statement
* over the last two decades several novel viral respiratory epidemics have rocked the world: [SARS Coronavirus](https://en.wikipedia.org/wiki/Severe_acute_respiratory_syndrome) (2002-2003), [H1N1 Influenza](https://en.wikipedia.org/wiki/Influenza_A_virus_subtype_H1N1), [MERS Coronavirus](https://en.wikipedia.org/wiki/Middle_East_respiratory_syndrome-related_coronavirus) (2012), [COVID-19](https://en.wikipedia.org/wiki/Coronavirus_disease_2019) (2019-2020), etc.
* collectively these viruses have causes thousands of deaths and billions of dollars in lost productivity: the [world bank estimates](https://www.weforum.org/agenda/2018/05/how-epidemics-infect-the-global-economy-and-what-to-do-about-it/) that each of these epidemics has resulted in loss of 0.7% of worldwide GDP (or approximately $570B annually)
* any of these viral epidemics can potentially become a ***_worldwide pandemic_*** like the Spanish Flu of 1919-1920, which infected approximately 27% of all people on Earth and killed 50-100m people worldwide.
* because of widespread air travel, these modern viral infections have spread throughout the world, as illustrated by the rapid spread of Wuhan coronovirus in 2019-2020:

![wuhan coronavirus spread, source: wikipedia](https://upload.wikimedia.org/wikipedia/commons/b/b3/COVID-19-outbreak-timeline.gif)

_worldwide spread of Wuhan Coronavirus December 2019 to February 2020, source: wikipedia_

* For novel viruses few treatment options exist. Developing vaccines and antiviral therapeis can take years, at which point a virus could have become a pandemic. The most effective (and sometimes only) strategy is ***_containment_***.
* Because these infections have a latent period and can spread readily from one person to another, ***_the central challenge of containing infection is to identifying who has been exposed to infected individuals._*** 
  * Historically this has been a labor intensive process requiring public health officials to laboriously identify anyone who might have been in proximity to an infected person (e.g. who are their neigbhoors, who sat next to them on an airplane, etc). Unfortunatly these approaches are slow, labor-intensive, and often fail to promptly identify many people who were exposed.
  * Identifying where infected people have been is the key to finding those who are at risk for infection.
* A novel approach for rapidly identifying individuals who may have been exposed to infected hosts is desperately needed.


## proposed solution
* ***Our mobile app and associated platform takes advantage of the fact that modern smartphones are ubiquitous, able to collect geospatial data, and able to share it over secure networks. By developing a privacy preserving algorithm, we enable users to immediately see if they have been exposed to infected individuals without risking exposure of thier location data.***
 * individuals can download an app to see information about where infections have been reported
 * this app also securely tracks users locations
 * this information can be used to identify if a user has been in the same location as an infected person

## [design of app and platform](https://github.com/nickmmark/infection-tracking/blob/master/DESIGN.md)
* there are two core pieces of the platform
  * a mobile app that can provide information about outbreaks and securely track locations
  * a platform that can identify exposure between infected individuals and other users
  
  ## Geotemporalspatial encoding of data
* objective: combine time and location data into a encrypted hash; the ciphertext can be compared to look for ```collisions``` without compromising the users privacy by revealing thier location.

### overview of enabling technologies
* Geohash is an open source method developed in 2008 to turn two (or more) spatial coordinates into a single hashed value
* The technology turns a time series of geospatial coordinates into an encrypted and anonymized dataset; if a known infected person is identified the platform can search for other individuals who occupied the same place at the same time (they share identical geotemporal coordinates).
* users who are potentially exposed can see alerts tagged to thier UUIDs

![overview of technology](https://github.com/nickmmark/infection-tracking/blob/master/technology_idea.png)

### encoding
* each user is assigned an anonymous UUID (this is done according to the ISO 9834 standard)
* at periodic intervals spatial coordinates captured and converted into a ```geohash``` (using the public domain geocode system invented in 2008 by Gustavo Niemeye)
* the ```geohash``` is combined with the time (express in UTC as per the ISO8601 standard, rounded to a five minute intervan) to make a ```geotemporal hash```
* the ```geotemporal hash``` is encrypted using public key cryptography (using the open source Curve25519 schema)
* thus a persons position at a given time(e.g. ```geotemporal hash```) is encrypted

### looking for collisions
* if two persons were in the same place at the same time (a ```collision```) they should share the same value for the ```geotemporal hash```. Assuming that both are encrypted using the same public key they will have an identical ciphertext value.
* this means that we can compare the ciphertext to look for ```collisions``` between individuals _without knowing where they actually were_
* this is valuable because it preserves privacy but enables a rapid efficient search
* as a second layer of privacy, users are entered in the database using UUIDs (not names or other identifiers)


### examples
```R
# load libraries
library(geohash)
library(sodium)
library(lubridate)
library(uuid)

# encode geotemporal data
userID <- UUIDgenerate(use.time = FALSE)                    # unique identifier, using ISO 9834 standard
time <- force_tz(Sys.time(), tzone = "UTC", roll = FALSE)   # date-time in UTC, using ISO 8601 standard
time <- round_date(time, "5 mins")                          # round time to 5 minute blocks
lat <- 47.570261                                            # ent spatial coordinates
long <- -122.294088

coord_hash <- gh_encode(lat, long, precision = 10)          # turn coordinates into geohash
neighboors_hash <- gh_neighbours(coord_hash)                # identify neighbooring squares
coord_decoded <- gh_decode(coord_hash)

# create geotemporal hash
geotemporal_string <- paste(time,coord_hash, sep = " ", collapse = NULL) # combine the time and coordinates together

# generate private and public keys
private_key <- keygen()
public_key <- pubkey(private_key)

# encrypt geohashes using curve25519 encryption and public key
coord_ciphertext <- simple_encrypt(charToRaw(geotemporal_string), public_key)

# decrypt geohashes using the key
coord_decrypted <- simple_decrypt(coord_ciphertext, private_key)
coord_decoded <- gh_decode(rawToChar(coord_decrypted))

# show the progression of data from start to end
print(time)
print(lat)
print(long)
print(coord_hash)
print(neighboors_hash)
print (geotemporal_string)
print (coord_ciphertext)
print (coord_decrypted)
print (rawToChar(coord_decrypted))
print(coord_decoded)
```

![](https://github.com/nickmmark/infection-tracking/blob/master/technology_example.png)


### libraries used
* [Sodium Cryptography library](https://cran.r-project.org/web/packages/sodium/vignettes/intro.html)
* [Geohash libary](https://www.rdocumentation.org/packages/geohash/versions/0.3.0)
* [Lubridate](https://cran.r-project.org/web/packages/lubridate/index.html)
* [UUID](https://cran.r-project.org/web/packages/uuid/index.html)

