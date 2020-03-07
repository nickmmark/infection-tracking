## geospatial temporal encoding for historical propinquity identification 
## nick mark, md 2020-02-20
## 

## overall design: userID + coordinates + time --> hash --> encrypted value

## section I: test cases
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

geotemporal_string <- paste(time,coord_hash, sep = " ", collapse = NULL) # combine the time and coordinates together


coord_df <- data.frame(userID, time, time_as_string, lat, long, coord_hash) # dataframe

print(time)
print(lat)
print(long)
print(coord_hash)
print(neighboors_hash)
print (geotemporal_string)

# generate private and public keys
private_key <- keygen()
public_key <- pubkey(private_key)

# encrypt geohashes using curve25519 encryption and public key
coord_ciphertext <- simple_encrypt(charToRaw(geotemporal_string), public_key)
print(coord_ciphertext)

# decrypt geohashes using the key
coord_decrypted <- simple_decrypt(coord_ciphertext, private_key)
print (coord_decrypted)
coord_decoded <- gh_decode(rawToChar(coord_decrypted))
print(coord_decoded)


## section II: proposed three functions that instanciate this idea

encrypt_geotemporal <- function(lat, long, time){
  # pass a position and a time and return the encrypted code for both
  # convert time to UTC
  # convert lat/long to geohash
  # combine time/geohash into one string
  # encrypt using an established public key
  # return GEOTEMPORAL HASH
}

log_geotemporalhash <- function(geotemporal, log_file){
  # write the specified encrypted has to a specified log file
}

collision_check <- function(test_coord_hash, test_time, log_file){
  # check for collisions by comparing the given coordinates_hash against the log
  # step load log file
  # calculate the neighbooring squares
  # compare coordinate_hash, neighboors_hash against the database
  # return TRUE if the user co-incides with another user/neighboor in the database
}


