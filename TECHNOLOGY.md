# overview of enabling technologies



### stack

* Geohash is an open source method developed in 2008 to turn two (or more) spatial coordinates into a single hashed value
* 


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
lat <- 47.570261                                            # spatial coordinates
long <- -122.294088

coord_hash <- gh_encode(lat, long, precision = 10)          # turn coordinates into geohash
neighboors_hash <- gh_neighbours(coord_hash)                # identify neighbooring squares
coord_decoded <- gh_decode(coord_hash)

geotemporal_hash <- paste(time,coord_hash, sep = "", collapse = NULL) # combine the time and coordinates together


coord_df <- data.frame(userID, time, time_as_string, lat, long, coord_hash) # dataframe

print(time)
print(lat)
print(long)
print(coord_hash)
print(neighboors_hash)
print (geotemporal_hash)

collision_check <- function(test_coord_hash, test_time, log_file){
  # check for collisions by comparing the given coordinates_hash against the log
  # step load log file
  # calculate the neighbooring squares
  # compare coordinate_hash, neighboors_hash against the database
  # return TRUE if the user co-incides with another user/neighboor in the database
}

encrypt_geotemporal <- function(lat, long, time){
  # pass a position and a time and return the encrypted code for both
  # convert time to UTC
  # convert lat/long to geohash
  # combine time/geohash into one string
  # encrypt using an established public key
}

### some problem with encryption - need to troubleshoot handling of data types (raw to char? char back to raw?)

# encrypt geohashes
key <- hash(charToRaw("Secret passphrase"))
nonce <- random(24)
coord_encrypted <- data_encrypt(charToRaw(geotemporal_hash), key, nonce)
print(coord_encrypted)

# decrypt geohashes with same key and nonce
coord_decrypted <- data_decrypt(coord_encrypted, key, nonce)
print (coord_decrypted)
coord_decoded <- gh_decode(coord_decrypted)
print(coord_decoded)

# load a log file of all geotemporal positions
```


### libraries used
[Sodium Cryptography library](https://cran.r-project.org/web/packages/sodium/vignettes/intro.html)
[Geohash libary](https://www.rdocumentation.org/packages/geohash/versions/0.3.0)
[Lubridate]
[
