# This function returns true if a file name includes "TOP_OF_HOUR"
def skip_toth(track_url) =
  string.match(track_url, "TOP_OF_HOUR") != nil
end

# Suppose your M3U is at /home/buck0five/playlists/store123.m3u
s = playlist("/home/buck0five/playlists/store123.m3u")

# dropwhere(...) removes any tracks for which skip_toth() returns true
s = dropwhere(skip_toth, s)

output.icecast(
  %mp3,
  host = "localhost",
  port = 8000,
  password = "hackme",
  mount = "store123",
  name = "Store 123",
  s
)
