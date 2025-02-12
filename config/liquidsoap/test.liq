# Simple built-in test tone
my_tracks = sine()

# Output to your Icecast
# Here, mount = "test" => http://<linode_ip>:8000/test
output.icecast(
  %mp3,             # Encode as MP3
  host = "localhost",  # or "50.116.43.51"
  port = 8000,
  password = "hackme",  # Must match <source-password> in /etc/icecast2/icecast.xml
  mount = "test",
  name = "POC Station",
  description = "Liquidsoap + Icecast POC",
  my_tracks
)
