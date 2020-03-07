# overview of enabling technologies
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


### libraries used
* [Sodium Cryptography library](https://cran.r-project.org/web/packages/sodium/vignettes/intro.html)
* [Geohash libary](https://www.rdocumentation.org/packages/geohash/versions/0.3.0)
* [Lubridate](https://cran.r-project.org/web/packages/lubridate/index.html)
* [UUID](https://cran.r-project.org/web/packages/uuid/index.html)
